# coding: utf-8
import json
import re
import copy

import jsonschema
from core import utils
from django.core import mail
from django_webtest import WebTest
from django.core.cache import cache
from json import JSONDecoder
from django.conf import settings
from webtest.app import AppError
from core.serializers import RegistryByPhoneSerializer
from core.models import DomofonUser
from pprint import pprint

from django.conf import settings
from django.test.runner import DiscoverRunner
from django.test import override_settings

TEST_THROTTLE_RATES = {
    'anon': '5/min',
    'user': '40/day',
}


class DomofonTestRunner(DiscoverRunner):
    def __init__(self, **kwargs):
        kwargs['debug_mode'] = True
        super(DomofonTestRunner, self).__init__(**kwargs)


class AuthMixin(object):
    def login_as(self, username='', password=''):
        self.user = username or 'admin'

        login_form = self.app.get(url='/login/').form  # click(u'Session Login')
        login_form['username'] = self.user
        login_form['password'] = password or 'wordpass'
        login_form.submit()
        self.csrf_token = self.app.cookies.get('csrftoken', '')

    def logout(self):
        self.app.cookies.clear()


class ChoicesViewSetTest(AuthMixin, WebTest):
    fixtures = ['domofonuser.json']

    # получаем значения для формы "пользовательские настройки" (slug='user_settings')
    def testGetUserSettings_Authorized(self):
        # self.login_as()  # as admin by default
        self.login_as(username='admin', password='wordpass')

        us = self.app.post(url='/api/get_choices/',
                           params={'slug': 'user_settings'},
                           user=self.user,
                           headers={'X-CSRFToken': self.csrf_token})

        assert us.json is not None

    def testGetUserSettings_UnAuthorized(self):
        try:
            us = self.app.post(url='/api/get_choices/',
                               params={'slug': 'user_settings'})
        except AppError as e:
            responce_msg = e.args[0]
            assert responce_msg.startswith('Bad response: 403 Forbidden (not 200 OK or 3xx ')


class DomofonUserViewSetTest(AuthMixin, WebTest):
    fixtures = ['domofonuser.json', 'group.json', 'domofonuser_groups.json']

    # телефон в/не_в базе клиента
    def testPhoneInClientDB(self):
        cache.clear()
        phone = '89992265654'
        in_db = self.app.post(url='/api/register_by_phone_number/',
                              params={'phone': phone})
        responce_msg = in_db.json['msg']
        pin = cache.get(phone)
        assert responce_msg.startswith(f'pin code {pin} was send')

        notin_db = self.app.post(url='/api/register_by_phone_number/',
                                 params={'phone': '+7800100501'})
        responce_msg = notin_db.json['errors']
        assert 'not a client' in responce_msg

    # данный телефон уже зарегистрирован в базе
    def testPhoneAlreadyWasAttached(self):
        cache.clear()
        already_attached = self.app.post(url='/api/register_by_phone_number/',
                                         params={'phone': '89991165659'})
        responce_msg = already_attached.json['errors']
        assert 'phone already was confirmed' in responce_msg

    # ограничение числа запросов от каждого Анонимуса
    # test_rate_setting = copy.deepcopy(settings.REST_FRAMEWORK)
    # test_rate_setting['DEFAULT_THROTTLE_RATES'] = TEST_THROTTLE_RATES
    # @override_settings(REST_FRAMEWORK=test_rate_setting)
    def testAnonRateCount(self):
        cache.clear()
        limit = int(settings.REST_FRAMEWORK['DEFAULT_THROTTLE_RATES']['anon'].split('/')[0])
        try:
            for i in range(limit + 1):
                too_rate_request = self.app.get('/api/anon_test_view/')
                # print('leaves for anon:{}'.format(too_rate_request.json['leaves']))
        except AppError as e:
            responce_msg = e.args[0]
            assert responce_msg.startswith('Bad response: 429')

    # пинкод генерируется с нужным числом цифр
    def testPinCodeHaveRightDigitsNumber(self):
        for i in range(4, 8):
            assert i == len(str(RegistryByPhoneSerializer._get_pin(i)))

    # полный pipeline успешной регистрации:
    # сценарий: телефон есть в базе клиента, П вводит не правильный пинкод 1 раз,
    # затем(второй раз) вводит правильный пинкод, происходит регистрация
    def testSuccessRegisterPipeline(self):
        cache.clear()
        # valid only for my personal MySQL sip_client_db, no fixtures
        phone = '89992265654'

        first_request = self.app.post(url='/api/register_by_phone_number/',
                                      params={'phone': phone})
        responce_msg = first_request.json['msg']
        pin = cache.get(phone)
        assert responce_msg.startswith(f'pin code {pin} was send')

        wrong_pin = 999  # поле сериалайзера допускает 999, а ф-ия _get_pin генерит по дефолту 4-значные
        wrong_pin_request = self.app.post(url='/api/register_by_phone_number/',
                                          params={'phone': phone, 'pin': wrong_pin})
        responce_msg = wrong_pin_request.json['msg']
        assert responce_msg == 'wrong pin code'

        right_pin = cache.get(phone)
        right_pin_request = self.app.post(url='/api/register_by_phone_number/',
                                          params={'phone': phone, 'pin': right_pin})
        responce = right_pin_request.json
        # ok, user created, test him
        assert responce['success'] is True
        # token was send, username is phone
        assert ('token' in responce) and ('username' in responce) and (responce['username'] == phone)
        # phone number was attached to created user
        user = DomofonUser.objects.get(auth_token=responce['token'])
        assert user.phone_confirmed is True
        # pprint(user)
        # pprint(f'user.phone_confirmed:{user.phone_confirmed}')

    def testGetUserSettings(self):
        self.login_as()  # as admin by defualt

        user_settings = self.app.get('/api/user_settings/').json

        assert type(user_settings) == dict

    def testSetAndGetUserSettings(self):
        self.login_as()  # as admin by defualt

        right_settings = {
            "background_color": "#0E4FDB",
            "ringtone": "../../wonderful_life.mp3",
            "video_select": "ON after answer",
            "video_resolution": "CIF",
            "video_bitrate": "1024kbps",
            "video_freq": "25fps",
            "video_codec": "matrosska",
            "transport": "udp"
        }

        set_user_settings = self.app.post(url='/api/user_settings/',
                                          params={'user_settings': json.dumps(right_settings)},
                                          user=self.user,
                                          headers={'X-CSRFToken': self.csrf_token}).json

        assert set_user_settings == ['ok']

        broken_settings = right_settings.copy()
        broken_settings.update({'transport': 'icarus'})

        set_user_settings = self.app.post(url='/api/user_settings/',
                                          params={'user_settings': json.dumps(broken_settings)},
                                          user=self.user,
                                          headers={'X-CSRFToken': self.csrf_token}).json

        assert "'icarus' is not one of ['udp', 'tcp']" in set_user_settings['errors'][0]

        # проверяем что настройки были сохранены
        get_user_settings = self.app.get(url='/api/user_settings/',
                                         user=self.user,
                                         headers={'X-CSRFToken': self.csrf_token}).json

        assert get_user_settings['settings'] == right_settings

    def testRetrieveFormatDataAtMeEndpoint(self):
        _schema = utils.get_json('me_endpoint_responce.json')
        users = DomofonUser.objects.all()
        for user in users:
            # print(user.user_info)
            self.login_as(username=user.username, password="wordpass")
            me_endpoint = self.app.get(url='/api/me/',
                                       user=self.user,
                                       headers={'X-CSRFToken': self.csrf_token}).json
            # if no exception - test passed - so we know
            # what responce valid by _schema
            try:
                jsonschema.validate(instance=me_endpoint, schema=_schema)
            except jsonschema.exceptions.ValidationError as ve:
                raise ValueError(f'wrong data for user_id={user.pk} at api/me endpoint')

            self.logout()


