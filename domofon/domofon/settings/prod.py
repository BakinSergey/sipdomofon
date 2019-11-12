from ..settings import *
from envparse import env

env.read_envfile()

DEBUG = False

ALLOWED_HOSTS = ['sip-domofon.ru', '0.0.0.0', 'localhost']

# Database
# https://docs.djangoproject.com/en/1.9/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': env.str('SIP_DB_NAME'),
        'USER': env.str('SIP_DB_USER'),
        'PASSWORD': env.str('SIP_PASS'),
        'HOST': env.str('SIP_DB_HOST'),
        'PORT': env.str('SIP_DB_PORT'),
        # 'ATOMIC_REQUESTS': True,
    }
}

client_db = {
    'ENGINE': 'django.db.backends.mysql',
    'NAME': env('CLIENT_DB_NAME'),
    'USER': env('CLIENT_DB_USER'),
    'PASSWORD': env('CLIENT_PASS'),
    'HOST': env('CLIENT_DB_HOST'),
    'PORT': '3306'
}

synapse_db = {
    'ENGINE': 'django.db.backends.postgresql_psycopg2',
    'NAME': env('SYNAPSE_DB_NAME'),
    'USER': env('SYNAPSE_DB_USER'),
    'PASSWORD': env('SYNAPSE_PASS'),
    'HOST': env('SYNAPSE_DB_HOST'),
    'PORT': '5432'
}

# use for user_id matching
synapse_server_name = env.str('SYNAPSE_SERVER_NAME')
synapse_server_host = env.str('SYNAPSE_HOST')
synapse_server_port = env.str('SYNAPSE_PORT')

# Password validation
# https://docs.djangoproject.com/en/1.9/ref/settings/#auth-password-validators
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'filter_custom': {
            '()': 'core.log.UserFilter'
        }
    },
    'handlers': {
        'file': {
            'level': 'WARNING',
            'class': 'logging.FileHandler',
            'filename': os.path.join(BASE_DIR, '..', 'logs/warnings.log'),
        },
    },
    'loggers': {
        'django': {
            'handlers': ['save_to_db', 'file'],
            'level': 'INFO',
            'propagate': True,
        },
    }
}