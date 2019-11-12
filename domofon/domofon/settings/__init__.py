from envparse import env
import os
import mimetypes
import socket

# for docker start
env.read_envfile()

# for NON docker start
# env.read_envfile('local.env')

DEBUG = env.bool('DEBUG')

TEMPLATE_DEBUG = DEBUG

# Raises django's ImproperlyConfigured exception if SECRET_KEY not in os.environ
SECRET_KEY = env('SECRET_KEY')

mimetypes.add_type('application/font-ttf', '.ttf')

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))

# Application definition
DJANGO_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]

THIRD_PARTY_APPS = [
    'corsheaders',
    'rest_framework',
    'rest_framework_swagger',
    'rest_framework.authtoken',
]

DEV_TOOLS = [
    # 'django_coverage',
]

# test reports dir
COVERAGE_REPORT_HTML_OUTPUT_DIR = os.path.join(BASE_DIR, 'cover')

# this project Apps
LOCAL_APPS = [
    'core',
    'sipdomofon'
]

INSTALLED_APPS = DJANGO_APPS + THIRD_PARTY_APPS + DEV_TOOLS + LOCAL_APPS

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    # 'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    # 'django.contrib.auth.middleware.SessionAuthenticationMiddleware', # else server not Running, obsolete in 1.10
    # but create by default
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

CORS_ORIGIN_ALLOW_ALL = True
# CORS_ORIGIN_WHITELIST = (,)
CORS_ALLOW_CREDENTIALS = True
# CSRF_TRUSTED_ORIGINS = (,)


ROOT_URLCONF = 'domofon.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'debug': DEBUG,
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages'
            ],
        },
    },
]

WSGI_APPLICATION = 'domofon.wsgi.application'

# Database

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': '',
        'USER': '',
        'HOST': '',
        'PORT': '',
        'PASSWORD': '',
    }
}

TEST_RUNNER = 'core.tests.DomofonTestRunner'

CLIENT_DB_E164 = True

AUTH_USER_MODEL = "core.DomofonUser"

# Internationalization
# https://docs.djangoproject.com/en/2.2/topics/i18n/

TIME_ZONE = 'W-SU'
LANGUAGE_CODE = 'ru'
USE_I18N = True
USE_L10N = True
USE_TZ = True

# STATIC FILE CONFIGURATION
# ------------------------------------------------------------------------------

STATIC_ROOT = os.path.join(BASE_DIR, '..', 'staticfiles/static')

STATIC_URL = '/static/'

STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'static'),
)
FIXTURE_DIRS = (
    os.path.join(BASE_DIR, 'fixtures'),
)

STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
)

# MEDIA CONFIGURATION
# ------------------------------------------------------------------------------
MEDIA_ROOT = os.path.join(BASE_DIR, '..', 'staticfiles/media')

MEDIA_URL = '/media/'

LOGIN_REDIRECT_URL = 'home'
LOGIN_URL = 'login'

# GOOGLE_KEY_FILE = os.path.join(BASE_DIR, 'secret.json')

INTERNAL_IPS = ('127.0.0.1',)

REST_FRAMEWORK = {

    'DEFAULT_PERMISSION_CLASSES': 'rest_framework.permissions.IsAuthenticated',

    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.BasicAuthentication',
        'rest_framework.authentication.TokenAuthentication',
    ),

    'DEFAULT_THROTTLE_CLASSES': [
        'rest_framework.throttling.AnonRateThrottle',
        'rest_framework.throttling.UserRateThrottle',
        'rest_framework.throttling.ScopedRateThrottle',
    ],
    'DEFAULT_THROTTLE_RATES': {
        'anon': '400/day',
        'user': '9999/day',
    },

    'DEFAULT_SCHEMA_CLASS': 'rest_framework.schemas.coreapi.AutoSchema',

    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.LimitOffsetPagination',
    'PAGE_SIZE': 10,

    #Parser classes priority-wise for Swagger
    'DEFAULT_PARSER_CLASSES': [
        'rest_framework.parsers.JSONParser',
        'rest_framework.parsers.FormParser',
        'rest_framework.parsers.MultiPartParser',

    ],
}

SWAGGER_SETTINGS = {

    # 'SECURITY_DEFINITIONS': {
    #     'api_key': {
    #         'type': 'apiKey',
    #         'in': 'header',
    #         'name': 'Authorization',
    #     }
    # },
    'USE_SESSION_AUTH': True,
    'JSON_EDITOR': False,
}


AUTHENTICATION_BACKENDS = (
    'django.contrib.auth.backends.ModelBackend',
)

CACHES = {
    'default': {
        'BACKEND': 'redis_cache.RedisCache',
        'LOCATION': 'localhost:6379',
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        }
    }
}

# время жизни СМС-кода(5 минут)
PHONE_CACHE_TTL = 300

# число попыток подтверждения одного номера через СМС-код
# (кейс - "не доходят смс")
# повторная отправка на этот номер возможна только через PHONE_CACHE_TTL секунд
PHONE_VERIFY_CNT_LIMIT = 5

# допустимое количество разных номеров, регистрируемых с одного ip.
# ключ висит в Redis, соотв. куча функционирует до рестарта редиса,
# после рестарта Redis эти ключи обнуляются
PHONE_CNT_REGISTERED_FROM_ONE_IP_LIMIT = 3
