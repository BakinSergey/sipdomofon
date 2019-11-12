from core.client_db_fns import get_domphones_by_phonenumb
from core.synapse_db_fns import get_user_access_token
from core.utils import get_json

from django.db import models
from django.contrib.auth.models import AbstractUser, Group, Permission
from django.contrib.postgres.fields import JSONField
from os import path


class DomofonUser(AbstractUser):
    class Meta:
        verbose_name = 'Пользователь'
        verbose_name_plural = 'Пользователи'

    NOT = 'empty'
    MALE = 'male'
    FEMALE = 'female'

    SEX = (
        (NOT, 'Не указан'),
        (MALE, 'Мужской'),
        (FEMALE, 'Женский'),
    )

    phone = models.CharField(verbose_name='Контактный телефон', max_length=30, blank=True)
    phone_confirmed = models.BooleanField(default=False, verbose_name='Телефон подтвержден')
    email_confirmed = models.BooleanField(default=False, verbose_name='Email подтвержден')

    avatar = models.ImageField(max_length=127, verbose_name='Фото профиля',
                               upload_to=path.join('user', 'logo'), default='./user/logo/default.png')

    skype = models.CharField(verbose_name='Логин в Skype', max_length=30, blank=True)

    sex = models.CharField(max_length=6, choices=SEX, default='empty', verbose_name='Пол')
    is_subscriber = models.BooleanField(default=False, verbose_name='Подписан на новости сервиса')

    user_info = JSONField(default=dict, blank=True)

    # связь с учетными записями из client_db (Client database)
    external_id = models.IntegerField(blank=True, null=True, unique=True)

    # связь с учетными записями из synapse_db (chat: Riot + Synapse)
    synapse_id = models.CharField(blank=True, null=True, max_length=80)

    def get_available_roles(self):
        if self.is_superuser:
            return Group.objects.all()
        available_groups = []
        for group in self.groups.all():
            available_groups.append(group)
        return set(available_groups)

    def get_roles(self):
        return [g.name for g in self.get_available_roles()]

    @property
    def info(self):
        return self.user_info.get('settings', {})


    @property
    def syn_token(self):
        syntoken_our = self.user_info.get('from_synapse_db', {}).get('access_token', {}),
        success, token = get_user_access_token(self.username)
        syntoken_real = token if success else None

        syntoken = syntoken_real

        if syntoken_our != syntoken_real:
            # ToDo update syntoken in SIP_DB
            pass
        return syntoken

    @property
    def full_info(self):
        syntoken = self.syn_token

        return {
            # "sip_id": self.user_info.get('from_client_db', {}).get('dom_phone', None),
            "sip_id": [i.get('uid') for i in self.user_info.get('from_client_db')],
            "phone": self.phone,
            "role": self.get_roles()[0],
            "synapse_token": syntoken,
            "missed_calls": 0,
            "door_phones": get_domphones_by_phonenumb(self.phone),
            "settings": self.user_info.get('settings', {})
        }

    @staticmethod
    def get_defualt_user_settings():
        jsettings = get_json('user_settings.json')
        default = {}
        for prop, value in jsettings['properties'].items():
            default.update({prop: value['default']})

        return default
