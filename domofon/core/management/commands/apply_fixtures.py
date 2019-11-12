import json
import sys, os
import subprocess

from collections import defaultdict
from domofon.settings import FIXTURE_DIRS
from django.core.management.base import BaseCommand


class Command(BaseCommand):

    def add_arguments(self, parser):
        # Named (optional) arguments
        parser.add_argument(
            '--model',
            dest='model',
            default=None,
            type=str,
            help='make Fixture only specified model',
        )

    def handle(self, **options):
        result = []
        if options['model']:
            fix_filename = options['model'] + '.json'
            if os.path.exists(os.path.join(FIXTURE_DIRS[0], fix_filename)):
                result.append(fix_filename)
            else:
                print(f'fixtures for model {options["model"]} not found')
        else:
            result = os.listdir(FIXTURE_DIRS[0])

        if result:
            for fixture in result:
                args = ["python", "manage.py", "loaddata", fixture]
                try:
                    process = subprocess.Popen(args, stdout=subprocess.PIPE)
                    data = process.communicate()
                except:
                    return
                if data[0]:
                    self.stdout.write(self.style.SUCCESS('fixture {} applied:'.format(fixture)))
                    self.stdout.write(self.style.SUCCESS(data[0].decode('utf-8')))
                else:
                    self.stdout.write(self.style.ERROR('wrong fixture file: {}'.format(fixture)))









