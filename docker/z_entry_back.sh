#!/bin/bash

# Prepare log files and start outputting logs to stdout
mkdir -p ./logs
touch ./logs/gunicorn.log
touch ./logs/gunicorn-access.log
tail -n 0 -f ./logs/gunicorn*.log &

#export DJANGO_SETTINGS_MODULE=domofon.settings.local

python ./domofon/manage.py makemigrations --settings=domofon.settings.local
python ./domofon/manage.py migrate --settings=domofon.settings.local
python ./domofon/manage.py collectstatic --no-input
#python ./domofon/manage.py runserver 0.0.0.0:8000 --settings=domofon.settings.prod
#python ./domofon/manage.py create_some_clients --synt_cnt=20 --test_cnt=40

sleep 60s  # fuck mysql

python ./domofon/manage.py create_some_clients
python ./domofon/manage.py runserver 0.0.0.0:8000 --settings=domofon.settings.local

# create some test clients




#exec gunicorn domofon.domofon.wsgi:application \
#    --name sip-domofon \
#    --bind 127.0.0.1:8000 \
#    --workers 1 \
#    --log-level=info \
#    --log-file=./logs/gunicorn.log \
#    --access-logfile=./logs/gunicorn-access.log \
"$@"