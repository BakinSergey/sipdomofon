import json

import requests

params = {'slug': 'client_user'}
url = 'http://178.124.222.234:8000/api/get_choices/'

headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Token adbab9234c1c9645797e2d20c7e587e619380724'
}

payload = {'slug': 'client_user', }

r = response = requests.post(url, headers=headers, data=json.dumps(payload))

print(r.content)
