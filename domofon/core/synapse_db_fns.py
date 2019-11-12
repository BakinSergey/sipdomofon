import json
from time import sleep

import psycopg2
import requests
from psycopg2.extras import RealDictCursor

from contextlib import closing

from django.conf import settings

if settings.DEBUG:
    from domofon.settings.local import synapse_db, synapse_server_name, synapse_server_host, synapse_server_port
    # from domofon.settings.my_local import synapse_db, synapse_server_name, synapse_server_host, synapse_server_port
else:
    from domofon.settings.prod import synapse_db, synapse_server_name, synapse_server_host, synapse_server_port

def connect_to_synapse_db():
    host = synapse_db['HOST']
    user = synapse_db['USER']
    password = synapse_db['PASSWORD']
    db_name = synapse_db['NAME']

    conn = psycopg2.connect(dbname=db_name, user=user,
                            password=password, host=host,
                            cursor_factory=RealDictCursor
                            )
    return conn


def get_data_from_table(conn, table, lookup_fields, where_cond={}, post_cond=''):
    where_string = " and ".join(["{}='{}'".format(par, value) for par, value in where_cond.items()])
    look_string = ','.join(lookup_fields) if lookup_fields else '*'
    cur = conn.cursor()
    if where_cond:
        cur.execute("SELECT {} FROM {} WHERE {} {};".format(look_string, table, where_string, post_cond))
    else:
        cur.execute("SELECT {} FROM {} {};".format(look_string, table, post_cond))

    matched = cur.fetchall()
    return matched  # list of RealDicts


def get_synapse_user_id(sip_user_login):
    return f'@p{sip_user_login}:{synapse_server_name}'


def get_user_access_token(sip_user_login):
    synapse_user_id = get_synapse_user_id(sip_user_login)
    lookup_fields = ['token']
    where_cond = {"user_id": synapse_user_id}
    post_cond = "ORDER BY id desc limit 1;"

    conn = connect_to_synapse_db()

    with closing(conn) as conn:
        token = get_data_from_table(conn, 'access_tokens', lookup_fields, where_cond, post_cond)

    if token:
        return True, token[0]['token']

    return False, 'no synapse_user'


def get_synapse_user_pk(sip_user_login):
    synapse_user_id = get_synapse_user_id(sip_user_login)
    lookup_fields = []
    where_cond = {'name': synapse_user_id}

    conn = connect_to_synapse_db()
    with closing(conn) as conn:
        synapser = get_data_from_table(conn, 'users', lookup_fields, where_cond)
    if synapser:
        return True, synapser[0]['name']

    return False, 'not synapse_user'


# ==========================================================================================


def create_test_synapsers(pack):

    host = f'http://{synapse_server_host}'
    port = synapse_server_port
    ep_reg_user = '/_matrix/client/r0/register'
    synapser_registred = 0

    for phone in pack:
        sleep(5)  # synapse server throttling rate
        un = f'p{phone}'
        pwd = 'wordpass'
        params = {"username": un, "password": pwd, "auth": {"type": "m.login.dummy"}}
        params = json.dumps(params)
        r = requests.post(f'{host}:{port}{ep_reg_user}', data=params)
        if r.status_code == 200:
            synapser_registred += 1
            print(f'{phone} was registred')
        else:
            print(f'{phone} was NOT registred, status:{r.status_code} - {r.content}')

    return synapser_registred


# user list on synapse_server
def get_synapse_users_list():
    conn = connect_to_synapse_db()
    lookup_fields = ['name']
    post_cond = "ORDER BY name desc;"

    with closing(conn) as conn:
        users = get_data_from_table(conn, 'users', lookup_fields=lookup_fields, post_cond=post_cond)

    if users:
        return [i['name'].split(':')[0][2:] for i in users]

    return []