import requests

URL = 'http://178.124.222.234:8000/login/'

client = requests.session()

client.get(URL)

csrftoken = client.cookies['csrftoken']

login_data = {
    'username': 'admin',
    'password': 'wordpass',
    'csrfmiddlewaretoken': csrftoken,
    'next': '/'
}

headers = {
    'accept': 'text/html',
    'Content-Type': 'application/x-www-form-urlencoded'
}

r = client.post(URL, data=login_data, headers=headers)

print(r.cookies)
