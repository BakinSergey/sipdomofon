from contextlib import closing
import pymysql
from django.conf import settings

from core.synapse_db_fns import create_test_synapsers
from core.utils import *

if settings.DEBUG:
    from domofon.settings.local import client_db
    # from domofon.settings.my_local import client_db
else:
    from domofon.settings.prod import client_db


# MySQL
def connect_to_client_db():
    host = client_db['HOST']
    user = client_db['USER']
    password = client_db['PASSWORD']
    db_name = client_db['NAME']

    try:
        conn = pymysql.connect(db=db_name, user=user,
                               password=password, host=host,
                               charset='utf8', cursorclass=pymysql.cursors.DictCursor
                               )
    except ConnectionError:
        return False, 'technical problem with connection to Client service'

    return conn


def get_data_from_table(conn, table, lookup_fields, where_cond={}):
    where_string = ' and '.join(['{}="{}"'.format(par, value) for par, value in where_cond.items()])
    look_string = ','.join(lookup_fields)
    cur = conn.cursor()
    cur.execute("SELECT {} FROM {} WHERE {};".format(look_string, table, where_string))
    matched = cur.fetchall()

    return matched  # list of dicts


def is_phone_in_client_db(phonenumb):
    # if settings.CLIENT_DB_E164:
    #     phonenumb = normalize_phone(phonenumb)

    if not is_mobile_phone_in_ru_kz(phonenumb):
        return False, 'it seems this is not RU or KZ mobile phone number'

    lookup = ['uid', 'dom_phone', 'level']
    where = {'mob_phone': phonenumb}

    conn = connect_to_client_db()
    with closing(conn) as conn:
        clients = get_data_from_table(conn, '_client', lookup, where)

        if clients:
            return True, handle_clients(clients)

    return False, 'no such phone'


def handle_clients(clients: list):
    return sorted(clients, key=lambda x: x['level'], reverse=True)


def get_domphones_by_phonenumb(phonenumb):
    res = []
    conn = connect_to_client_db()

    with closing(conn) as conn:
        # first - get client with that phone
        lookup = ['city', 'street', 'dom', 'podezd']
        where = {'mob_phone': phonenumb}

        clients = get_data_from_table(conn, '_client', lookup, where)

        for client in clients:
            # sec - get addreses
            lookup.append('dom_phone')
            where = {'city': client['city'], 'street': client['street'], 'dom': client['dom'],
                     'podezd': client['podezd']}

            addresses = get_data_from_table(conn, '_client_podezd', lookup, where)

            # Астана, ул.Ленина, 8 подъезд 4
            if addresses:
                for addr in addresses:
                    address = [client['city'], ', ', 'ул.', client['street'], ', ', client['dom'], ' ',
                               'подъезд', ' ', client['podezd']]
                    res.append({
                        'address': ''.join(address),
                        'sip_id': addr['dom_phone']
                    })

    return res


def prepare_test_clients(pack):
    entries = []

    # create test clients
    if 'test_numb' in pack:
        test_params = get_test_client_params(pack['test_numb'])
        test_entries = generate_client_podezd(test_params)
        entries.append(test_entries[:2])

    for e in entries:
        insert_test_clients(e)
    cnt = 20 if len(test_entries[2]) > 20 else len(test_entries[2])
    create_test_synapsers(test_entries[2][:cnt])


# load some fixture data to test clients_db
def insert_test_clients(clients):
    conn = connect_to_client_db()

    with closing(conn) as conn:

        cur = conn.cursor()
        # clients_fields = "'mob_phone','dom_phone','level', 'street','dom','podezd','city'"

        sql = "INSERT INTO _client (mob_phone, dom_phone, level, street, dom, podezd, city) " \
              "VALUES (%s, %s, %s, %s, %s, %s, %s)"

        for c in clients[0]:  # clients entries
            cur.execute(sql,
                        (c['mob_phone'], c['dom_phone'], c['level'], c['street'], c['dom'], c['podezd'], c['city'],))

        # podezd_fields = "'city','street','dom','podezd','dom_phone"
        sql = "INSERT INTO _client_podezd (city,street,dom,podezd,dom_phone) " \
              "VALUES (%s, %s, %s, %s, %s)"

        for p in clients[1]:  # podezd entries
            cur.execute(sql,
                        (p['city'], p['street'], p['dom'], p['podezd'], p['dom_phone'],))

        conn.commit()


# получаем телефоны активных пользователей
def get_active_clients_phones():

    lookup = ['DISTINCT mob_phone']
    where = {'level': 1}

    conn = connect_to_client_db()
    with closing(conn) as conn:
        clients = get_data_from_table(conn, '_client', lookup, where)

        if clients:
            return True, clients

    return False, 'no any client in db'

