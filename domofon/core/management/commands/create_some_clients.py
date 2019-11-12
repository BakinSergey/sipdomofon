import json
import sys, os
import subprocess
from django.core.management.base import BaseCommand
from core.client_db_fns import prepare_test_clients


class Command(BaseCommand):

    def add_arguments(self, parser):
        # Named (optional) arguments

        parser.add_argument(
            '--test_cnt',
            dest='test_cnt',
            default=None,
            type=int,
            help='number of test clients',
        )

    def handle(self, **options):
        result = []
        test_cnt = options['test_cnt'] if options['test_cnt'] else 80

        test_clients_pack = {'test_numb': test_cnt}

        try:
            prepare_test_clients(test_clients_pack)
            self.stdout.write(self.style.SUCCESS('test clients was inserted'))
        except:
            self.stdout.write(self.style.ERROR('test clients was NOT inserted'))
            return
