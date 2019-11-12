import random
import os
import jsonschema, json

import core.client_db_fns
import core.utils as utils
from core.custom_exceptions import *
from core.synapse_db_fns import get_synapse_user_pk, get_user_access_token, get_synapse_users_list
from core.models import DomofonUser

from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import Group

from rest_framework import serializers, status
from rest_framework.exceptions import ValidationError
from rest_framework.response import Response

from django.conf import settings
from django.core.cache import cache
from django.core.cache.backends.base import DEFAULT_TIMEOUT

PHONE_CACHE_TTL = getattr(settings, 'PHONE_CACHE_TTL', DEFAULT_TIMEOUT)
VERIFY_CNT_LIMIT = getattr(settings, 'PHONE_VERIFY_CNT_LIMIT')


# FROM_ONE_IP_LIMIT = getattr(settings, 'PHONE_CNT_REGISTERED_FROM_ONE_IP_LIMIT')


class DomofonUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = DomofonUser
        fields = '__all__'


class RegistryByPhoneSerializer(serializers.Serializer):
    phone = serializers.CharField(required=True, max_length=12, allow_blank=False)
    pin = serializers.IntegerField(required=False, min_value=999, max_value=9999, allow_null=True)

    def validate_phone(self, phone):
        # check in client db only first time (don't disturb Client_db with same phone)
        if cache.get(phone):
            return phone

        # must not be already attached and confirmed to some DomofonUser
        if DomofonUser.objects.filter(phone=phone, phone_confirmed=True).exists():
            raise serializers.ValidationError("phone already was confirmed")  # confirmed number

        # must be in client_db
        phone_e164 = utils.normalize_phone(phone)
        is_client, client = core.client_db_fns.is_phone_in_client_db(phone_e164)
        if not is_client:
            raise serializers.ValidationError("not a client")  # not a client
        else:
            cache.set(f'#{phone}::client_data', client, PHONE_CACHE_TTL)

        return phone

    def check_attemp(self, request):

        phone = self.data['phone']
        ip = utils.get_client_ip(request)

        ip_phone_key = f'attemps::{phone}::{ip}'
        ip_key = f'attemps::{ip}'

        if ip_phone_key in cache:
            if cache.get(ip_phone_key) > VERIFY_CNT_LIMIT:
                raise RegistryByPhoneError(f'limit sms attemps: {VERIFY_CNT_LIMIT}')
            cache.incr(ip_phone_key, 1)
        else:
            cache.set(ip_phone_key, 1)

        # if ip_key in cache:
        #     if cache.get(ip_key) > FROM_ONE_IP_LIMIT:
        #         raise RegistryByPhoneError(
        #             f'Число НОМЕРОВ для регистрации с Вашего IP: {FROM_ONE_IP_LIMIT} (превышено)')
        #     cache.incr(ip_key, 1)
        # else:
        #     cache.set(ip_key, 1)

        self.ip = ip
        return

    def registry_pin_step(self):

        phone = self.data.get('phone')
        pin = self.data.get('pin')

        if not cache.get(phone):
            res = self.ajax_send_pin(phone)  # for debug always 'success'
            if res == 'success':
                pin = cache.get(phone) if settings.DEBUG else ''
                ttl = f'TTL={PHONE_CACHE_TTL}' if settings.DEBUG else ''
                return f'pin code {pin}was send {ttl}'
            else:
                return 'sorry, try later'

        # число неправильных попыток не ограничивается.
        if not self._verify_pin(phone, pin):
            return 'wrong pin code'

        return 'phone was confirmed'

    @staticmethod
    def _get_pin(length=4):
        """ Return a numeric PIN with length digits """
        return random.sample(range(10 ** (length - 1), 10 ** length), 1)[0]

    def _verify_pin(self, phone, pin):
        """ Verify a PIN is correct """
        return pin == cache.get(phone)

    def ajax_send_pin(self, phone):
        """ Sends SMS PIN to the specified number """
        pin = self._get_pin()

        sms = 'код подтверждения:{}'.format(pin)
        res = utils.send_sms(phone, sms)
        if res == 'success':
            # store the PIN in the cache for later verification.
            cache.set(phone, pin, PHONE_CACHE_TTL)  # valid for 5 minutes

        return res

    def create_user(self):
        # some init
        user_data = {}
        groups_match = {1: 'regular', 2: 'support', 3: 'admin'}
        group = Group.objects.get(name='regular')

        phone = self.data.get('phone')

        # handle Synapse DB
        synapser, syn_pk = get_synapse_user_pk(phone)
        syn_token = None
        if synapser:
            syn_token = get_user_access_token(phone)[1]
        synapse_data = {'access_token': syn_token}

        # handle Client_DB
        client_data = cache.get(f'#{phone}::client_data')
        client_uid = client_data[0]['uid']  # uid of entry with max 'level' field value
        client_level = client_data[0]['level']
        is_active_client = client_level != 0

        # forming user data
        if is_active_client:
            group = Group.objects.get(name=groups_match[client_level])

        user_info = {}
        user_info.update({'settings': DomofonUser.get_defualt_user_settings()})
        user_info.update({'register_ip': self.ip})
        user_info.update({'from_client_db': client_data})
        user_info.update({'from_synapse_db': synapse_data})

        user_data['username'] = phone
        user_data['is_active'] = is_active_client
        user_data['phone'] = utils.normalize_phone(phone)
        user_data['password'] = make_password(str(phone)[::-1])  # reversed phone number
        user_data['phone_confirmed'] = True  # attach phone number to user
        user_data['user_info'] = user_info
        user_data['external_id'] = client_uid
        user_data['synapse_id'] = syn_pk if synapser else 0

        # create and tuning new user entry
        serializer = DomofonUserSerializer(data=user_data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        user.groups.add(group)

        # clear cache
        cache.delete(phone)
        cache.delete(f'#{phone}::client_data')
        cache.delete(f'attemps::{phone}::{self.ip}')

        return user


class UserSettingsSerializer(serializers.Serializer):
    user_settings = serializers.JSONField()

    def validate_user_settings(self, value):

        if not value:
            return value

        # try validate data by this schema here:
        # https://jsoneditoronline.org/?id=9a132ea5fc5d45a69335fa0a1775d80c
        _schema = utils.get_json('user_settings.json')

        if value:
            try:
                jsonschema.validate(instance=value, schema=_schema)
            except jsonschema.exceptions.ValidationError as ve:
                raise serializers.ValidationError(ve)
        return value


class ChoicesSerializer(serializers.Serializer):
    PREDEFINED = ['user_settings', 'client_user', 'registry_settings', ]

    slug = serializers.ChoiceField(required=True, allow_blank=False, choices=PREDEFINED)

    # список клиентов с указанием зарегился ли у нас как пользователь
    @staticmethod
    def get_user_clients():
        clients_phones = [i['mob_phone'] for i in core.client_db_fns.get_active_clients_phones()[1]]
        user_phones = DomofonUser.objects.values_list('username', flat=True)
        synapse_users = get_synapse_users_list()

        res = {i: ('already registered' if i in user_phones else 'NOT REGISTRED',
                   'SYNAPSE USER' if i in synapse_users else 'not Synapse user')
               for i in clients_phones
               }
        return res

    def get_result(self):
        result = {}

        if self.data['slug'] == self.PREDEFINED[0]:
            user_settings_data = utils.get_json('user_settings.json')
            result.update({"properties": user_settings_data['properties']})
            result.update({"ui_strings": user_settings_data['ui_strings']})

        if self.data['slug'] == self.PREDEFINED[1]:
            if settings.DEBUG:
                result = self.get_user_clients()
            else:
                result = {}

        if self.data['slug'] == self.PREDEFINED[2]:
            result = {
                'PHONE_CACHE_TTL': PHONE_CACHE_TTL,
                'VERIFY_CNT_LIMIT': VERIFY_CNT_LIMIT
            }

        return result
