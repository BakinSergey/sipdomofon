#!/bin/bash

psql -d sip_db -U sip_user < tmp/load_sip_db_dump.sql

"$@"