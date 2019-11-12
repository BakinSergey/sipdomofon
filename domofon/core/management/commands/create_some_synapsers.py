import json
import requests

import json
import sys, os
import subprocess
from django.core.management.base import BaseCommand
from core.client_db_fns import prepare_test_clients

class Command(BaseCommand):

    def add_arguments(self, parser):
        # Named (optional) arguments
        parser.add_argument(
            '--synt_cnt',
            dest='synt_cnt',
            default=None,
            type=int,
            help='number of syntetic clients',
        )
        parser.add_argument(
            '--test_cnt',
            dest='test_cnt',
            default=None,
            type=int,
            help='number of test clients',
        )

    def handle(self, **options):
        result = []
        synt_cnt = options['synt_cnt'] if options['synt_cnt'] else 4
        test_cnt = options['test_cnt'] if options['test_cnt'] else 200

        test_clients_pack = {'synt_numb': synt_cnt, 'test_numb': test_cnt}

        try:
            prepare_test_clients(test_clients_pack)
            self.stdout.write(self.style.SUCCESS('test clients was inserted'))
        except:
            self.stdout.write(self.style.ERROR('test clients was NOT inserted'))
            return
