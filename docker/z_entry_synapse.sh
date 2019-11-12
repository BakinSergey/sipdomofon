#!/bin/sh

#psql -d synapse_db -U sip_user < tmp/load_synapse_db_dump.sql

sleep 25s
synctl start --no-daemonize

"$@"