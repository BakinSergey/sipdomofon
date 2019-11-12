import json
import os
import random
import string

import phonenumbers
from core.custom_exceptions import *
from django.conf import settings
from django.db import models

from core import client_db_fns


def htmlColorToJSON(htmlColor):
    if htmlColor.startswith("#"):
        htmlColor = htmlColor[1:]
    try:
        return {
            "red": int(htmlColor[0:2], 16) / 255.0,
            "green": int(htmlColor[2:4], 16) / 255.0,
            "blue": int(htmlColor[4:6], 16) / 255.0}
    except (TypeError, ValueError):
        raise HTMLcolorError("не правильная Htmlcolor строка")


def is_mobile_phone_in_ru_kz(number):
    phone = phonenumbers.parse(number, "RU")
    if phone.country_code == 7:
        if number.startswith('+'):
            return len(number[2:]) == 10
        if number.startswith('8'):
            return len(number[1:]) == 10
    return False


def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip


def normalize_phone(number):
    """
    :param phone: raw phone number
    :return: phone number in E164 format
    """
    # E164 = phonenumbers.format_number(number, phonenumbers.PhoneNumberFormat.E164)
    # return E164
    return number


class SmsService:
    def send_always(self, phone, sms):
        return "success"


def send_sms(phone, sms_text, service=SmsService()):
    """
    send sms by client sms-gate service
    """
    phone = normalize_phone(phone)
    return service.send_always(phone, sms_text)


def get_json(jfile):
    schema = os.path.join(settings.BASE_DIR, 'static', 'jsondata', jfile)

    with open(schema, encoding='utf-8') as j:
        _schema = json.loads(j.read())

    return _schema


NAMES = ['Ivan', 'Petr', 'Maria', 'Aivaz', 'Revaz', 'Ali', 'Goga', 'Petro', 'Oleg', 'Bonifacy', 'Anton']

SURNAMES = ['Trio', 'Dio', 'Secund', 'Maibah', 'Volvo', 'Gucci', 'Travolta', 'Mendes', 'Buzoff', 'Lopes',
            'Gonsalez']

STREETS = ['Тургенева', 'Чапаева', 'Гусева', 'Уткина', 'Алисы Селезневой', 'Вилли Токарева', 'Атанбаева',
           'Курбан-оглы-Берды-Мухаммедова', 'Стаса Нерукотворного', 'Великих программистов', 'Бременских музыкантов',
           'Чайковского', 'Чехова', 'Паустовского', 'Зильберштейна', 'Вассермана', 'Дунаевского',
           'Сергея-Django-Бакина', 'Петросяна и Ко', 'Теймураза Абишевича'
           ]

CITIES = ['Алматы', 'Шымкент', 'Нур-Султан', 'Караганда', 'Актобе', 'Тараз', 'Павлодар', 'Усть-Каменогорск', 'Семей',
          'Атырау',
          'Костанай', 'Кызылорда', 'Уральск']


def get_syntetic_clients_params(clients_cnt):
    return {
        'cnt': clients_cnt,  # число entry к-е нужно генерить
        'prefix': [],
        'len_prefix': 0,
        'numlen': 2,
        'city': ['A', 'B'],
        'street': ['a', 'b'],
        'dom_phone': [1, 2, 3, 4]
    }


def get_real_client_params(clients_cnt):
    return {
        'cnt': clients_cnt,  # число entry к-е нужно генерить
        'prefix': ['8912', '8906', '7912'],
        'len_prefix': 4,
        'numlen': 7,
        'city': random.sample(CITIES, 3),
        'street': random.sample(STREETS, 9),
        'dom_phone': list({i + random.randint(10000, 99989) for i in range(10)})
    }


def get_test_client_params(clients_cnt):
    return {
        'cnt': clients_cnt,  # число entry к-е нужно генерить
        'prefix': ['89127304', '89068294'],
        'len_prefix': 8,
        'numlen': 11,
        'city': random.sample(CITIES, 3),
        'street': random.sample(STREETS, 9),
        'dom_phone': list({i + random.randint(10000, 99989) for i in range(10)})
    }


def get_client(params):
    return {
        # "uid" - key, auto increment
        "mob_phone": params.get('phone', generate_phone_number(params)),
        "dom_phone": random.choice(params['dom_phone']),
        "level": 1,  # 0 - used for non active(== disabled) client entries
        "street": random.choice(params['street']),
        "dom": random.choice(range(1, 100)),
        "podezd": random.choice(range(1, 10)),
        "city": random.choice(params['city'])
    }


def get_podezd(client):
    return {
        # "oid": auto increment
        "street": client['street'],
        "street_old": '',
        "dom": client['dom'],
        "dom_old": '',
        "podezd": client['podezd'],
        "dom_phone": client['dom_phone'],
        "city": client['city']
    }


# в params - параметры рандомности полей:
# params:
#   prefix - начало для номера телефона '+7905' итп
#   numlen - число знаков в номере телефона
#   city   - список городов для выбора
#   street - список улиц для выбора


def generate_client_podezd(params):
    clients_entries = []
    podezd_entries = []
    synapsers = []
    for c in range(params.get('cnt')):
        _client = get_client(params)
        if _client not in clients_entries:
            clients_entries.append(_client)
        else:
            continue

        client = clients_entries[-1]

        client_params = params.copy()  # surface copy!
        client_params['phone'] = client['mob_phone']
        podezd_entries.append(get_podezd(client))

        # decide synapser or not
        if random.choice([False, True]):
            synapsers.append(f'{client["mob_phone"]}')

        # create some podezd's for client with that mob_phone
        for p in range(random.choice([0, 1, 2])):
            clients_entries.append(get_client(client_params))
            client = clients_entries[-1]
            podezd_entries.append(get_podezd(client))

    return clients_entries, podezd_entries, synapsers


# def print_clients(clients):
#     client, podezd = clients
#     for c in client:
#         print(f'{c["mob_phone"]} -> {c["city"]}+{c["street"]}+{c["dom"]}+{c["podezd"]} :: {c["dom_phone"]}')
#
#     print()
#
#     for p in podezd:
#         print(f'{p["city"]}+{p["street"]}+{p["dom"]}+{p["podezd"]} :: {p["dom_phone"]}')

# from core import utils
# syntetic = utils.get_syntetic_clients_params(4)
# tc = utils.generate_client_podezd(syntetic)
# utils.print_clients(tc


# base = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(numb_len))
# random and unique phone numb generator
def generate_phone_number(params):
    stack = []

    numb_len = params['numlen'] - params['len_prefix']

    while True:
        base = ''.join(random.choice(string.digits) for _ in range(numb_len))

        prefix = random.choice(params['prefix']) if params['prefix'] else random.choice(['+7', '8'])

        phone = prefix + base

        if phone in stack:
            continue
        else:
            stack.append(phone)

        return phone


def random_name():
    yield (random.choice(NAMES), random.choice(SURNAMES),)

# def create_domofon_user_fixtures(count):
#     clients = []
#     for i in range(1, count):
#         new_client = {
#             "uid": i,
#             "cid": 0,  # "Компания"
#             "blocked": 0,  # "Блокировка"
#             "archive": 0,  # "Удален"
#             "neclient": 0,  # "Гость"
#             "created_at": "0000-00-00 00:00:00",  # "Добавлен"
#             "updated_at": "0000-00-00 00:00:00",  # "Обновлен"
#             "level": 0,  # "Уровень доступа"
#
#             "did": 0,  # "ID в справочнике"
#             "pid": 0,  # "Персонал"
#             "lc_aec": None,  # "АЕС"
#             "lc_erc": None,  # "ЕРЦ"
#             "phone": None,  # "Телефон"
#             "name": None,  # "ФИО"
#             "info": None,  # "Описание, должность, компания, коментарий"
#             "city_meaning": 3,  # "Префикс населённого пункта",
#             "city": "Астана",  # "Населённого пункта"
#             "street_meaning": None,  # "Префикс улицы"
#             "street": None,  # "Улица"
#             "street_old": None,  # "Улица (старое)"
#             "dom": None,  # "Номер строения"
#             "dom_old": None,  # "Номер (старый)"
#             "podezd": None,  # "Подъезд"
#             "podezd_kv": None,  # "Квартиры подъезда"
#             "kv": None,  # "Квартира"
#             "zhk": None,  # "Жилой комплекс"
#
#             "category": 0,  # "0 - low, 1-middle, 2-high"
#             "birthday": None,  # "День рождения клиента"
#             "last_birthday_congrat": None,  # "Штамп времени, когда поздравили крайний раз"
#             "happy_birthday": "0",  # "Поздравлять клиента с днем рождения"
#
#             "created_by": None,  # "Автор"
#
#             "updated_by": None,  # "Автор обновления"
#             "uon_sync_need": "1",
#             "uon_id": "0",
#             "mob_phone": generate_phone_number(10),  # "Мобильный телефон"
#             "dom_phone": None  # "Номер SIP"
#         }
#         clients.append(new_client)
