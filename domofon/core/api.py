from django.conf.urls import url, include
from django.urls import path
from django.conf import settings
from django.core.cache import cache

from rest_framework import generics, viewsets, serializers, status
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.generics import get_object_or_404, UpdateAPIView, CreateAPIView
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.exceptions import ValidationError
from rest_framework.routers import DefaultRouter
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authtoken.models import Token
from rest_framework.routers import DefaultRouter
from rest_framework.throttling import AnonRateThrottle, BaseThrottle, ScopedRateThrottle

from core.serializers import RegistryByPhoneSerializer, UserSettingsSerializer, ChoicesSerializer
from core.serializers import RegistryByPhoneError
from core.models import DomofonUser
from core.client_db_fns import prepare_test_clients
from django.contrib.auth.models import Group


from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token


class CustomAuthToken(ObtainAuthToken):
    """
    api-token-auth:
    ## Аутентификация по: логин/пароль ##

    ## Параметры:
        username - строка, логин пользователя
        password - строка, пароль пользователя

    ## Ответ:
        'token': token.key, (токен пользователя в SIP-Domofon)
        'user_id': user.pk,
        'synapse_token': user.syntoken (токен пользователя в Synapse)
    """

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'synapse_token': user.syn_token
        })


class TestApiViewSet(viewsets.GenericViewSet):
    """
anon_rate_view:
## throttle_test_view  для anonymous ##

## Параметры:
    без параметров

## Ответ:
    "ok" : True  # в том смысле что - запрос получен
    "leaves" : 156  # оставшееся число анонимных запросов(на эти сутки)
"""

    @action(detail=False, permission_classes=(AllowAny,))
    def anon_test_view(self, request):
        limit = int(settings.REST_FRAMEWORK['DEFAULT_THROTTLE_RATES']['anon'].split('/')[0])
        host_ip = '127.0.0.1'
        anon_key = f'throttle_user_{host_ip}'
        leaves = limit - len(cache.get(anon_key))
        return Response({"ok": True, "leaves": leaves}, status=status.HTTP_200_OK)


    # @action(detail=False, permission_classes=(AllowAny,))
    # def create_clients(self, request):
    #     test_clients_pack = {'test_numb': 50}
    #     prepare_test_clients(test_clients_pack)
    #     return Response({"ok"}, status=status.HTTP_200_OK)


class ChoicesViewSet(viewsets.GenericViewSet):
    """
get_choices:
## Получить предопределенные значения ##
    Эндпоинт отдает данные для отрисовки форм на фронтенде
    и другие согласованные(предопределенные) данные

## Параметры:
    slug - определяет какие choices запрашиваются, тип string.
    Возможные значения:
    "user_settings" - настройки для конкретного пользователя.
    "client_user" - список клиентов с указанием регистрации 'у нас'(для отладки).
    "registry_settings" - настройки регистрации.

Ответ при slug='user_settings' (формат json):

    {
    "properties": {
    "background_color": {
      "description": "background color",
      "type": "string",
      "default": "#64ff64"
    },
    "ringtone": {
      "description": "ringtone file",
      "type": "string"
    },
    "video_select": {
      "description": "show video before or after answer",
      "enum": [
        "before","after"]
    },
    "video_resolution": {
      "description": "video resolution",
      "enum": ["QCIF","CIF","720P"]
    },
    "video_bitrate": {
      "description": "video bitrate",
      "enum": ["128kbps","256kbps","512kbps","1024kbps","2048kbps"]
    },
    "video_freq": {
      "description": "video frequency",
      "enum": ["5fps","10fps","15fps","20fps","25fps","30fps"]
    },
    "video_codec": {
      "description": "video codec",
      "type": "string"
    },
    "transport": {
      "description": "protocol",
      "enum": ["udp","tcp"]
     }
    },
    "ui_strings": {
      "ru_ru": {
        "background color": ["Выберите тему", "Цветовая тема"]
        "ringtone file": ["Выберите", "Звук уведомления"]
        "show video before or after answer": ["Показывать видео до или после ответа на звонок?", "Видео"]
        "video resolution": ["разрешение видео","Видео, resolution"]
        "video bitrate": ["плотность видеопотока", "Видео, bitrate"]
        "video frequency": ["Частота кадров, в сек","Видео, freq"]
        "video codec": ["видеокодек", "Видео, codec"]
        "protocol": ["протокол передачи", "Видео, protocol"]
      }
    }

Данные полей формы "Настройки пользователя"(кодовое имя, тип значения, варианты значений) - поле Properties ответа.
Объект ui_strings['ru_ru'] - содержит "screen values" - widjet.text, widget.tooltip

"""
    @action(detail=False, methods=['post'], permission_classes=(AllowAny,))
    def get_choices(self, request, *args, **kwargs):
        result = self.get_result(request)
        return Response(result, status=status.HTTP_200_OK)

    def get_result(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        result = serializer.get_result()
        return result

    def get_serializer(self, *args, **kwargs):
        return ChoicesSerializer(*args, **kwargs)


class DomofonUserViewSet(viewsets.GenericViewSet):
    """
register_by_phone_number:
## Регистрация по номеру телефона ##
В процессе регистрации производится верификация номера через СМС с пин-кодом,
число попыток верификации(число смс) на один номер: 5,
время на подтверждение номера(на ввод кода из смс): 5 минут
В случае успешной верификации создается новый пользователь:
**username** = номер телефона, **password** = номер телефона в обратном порядке, включая знак '+'
(предложить пользователю изменить пароль)


## Параметры:

    phone - обязательный параметр. Номер телефона, на который производится регистрация. Тип параметра: строка длиной, не более 11 символов.

    pin	  - не обязательный параметр. Пинкод из СМС сообщения. Тип параметра: целое число в интервале 1000-9999.

## Последовательность работы с эндпоинтом:

1.Первый запрос, содержит только **phone**.

  Возможные ответы сервера:
<br>
1.1 Номер не найден в базе клиентов сервиса:
**_{"errors": ["phone : not a client"], "success": false}_**
<br>
1.2 Номер уже был зарегистрирован(т.е. уже есть пользователь с этим номером):
**_{"errors": ["phone : phone already was confirmed"], "success": false}_**
<br>
1.3 Число попыток регистрации(кол-во отправленных смс) превысило установленный сервисом лимит:
**_{"errors": "limit sms attemps: 5",  "success": false}_**
<br>
1.4 Технические неполадки с сервисом отправки СМС:
**_{"msg": "sorry, try later",  "success": false }_**
<br>
1.5 "Успешный кейс", переход ко второму запросу(ввод пинкода):
**_{"msg": "pin code {pin} was send, TTL=300",  "success": false}_**
отправлено СМС, время на подтверждение: 300 секунд; сам пин {pin} будет показан только при DEBUG=True
<br>
2.Второй запрос, содержит **phone** и **pin**.

  Возможные ответы сервера:
<br>
2.1 Неправильный код подтверждения:
**_{"msg": "wrong pin code", "success": false }_**
<br>
2.2 Пользователь с таким именем уже есть:
**_{"errors": ["username : Пользователь с таким именем уже существует."], "success": false}_**
(теоретический кейс. невозможен, если выполнено условие 1.2)
<br>
2.3 "Успешный кейс" - создаем пользователя и возвращаем его токен, для авторизации запросов:
**_{"token": "75781d2d219bf5e36e6ce10bdaf3d2a7ab331f0d", "success": true, "username": "+7800100600"}_**
<br>

[Яндекс](http://yandex.ru)


user_settings:
## Сериализация настроек пользователя ##

## Параметры:
    для  GET запроса: без параметров, запрос от аутентифицированного пользователя
    для POST запроса: единственный параметр "user_settings": {}, в котором нужно передать JSON объект следующей структуры:
    {
      "user_settings":
        {"transport":"tcp",
        "video_bitrate":"2048kbps",
        "video_freq":"15fps",
        "video_resolution":"QCIF",
        "video_select":"ON before answer",
        "background_color": "#0E4FDB",
        "ringtone": "NoizeMC feat Basta",
        "video_codec": "some codec name"
        }
    }
      Возможные значения каждого параметра в объекте смотреть по ответу на запрос
      Api/get_choices с параметром slug="user_settings"

me:
## Набор базовой информации о пользователе ##
    Без параметров, ответ содержит данные по пользователю:
    {
      "sip_id": null,
      "phone": "+7800800800",
      "role": "regular",
      "missed_calls": 0,
      "door_phones": [],
      "settings": {
        "ringtone": "../../wonderful_life.mp3",
        "transport": "udp",
        "video_freq": "15fps",
        "video_codec": "matrosska",
        "video_select": "before",
        "video_bitrate": "1024kbps",
        "background_color": "#64ff64",
        "video_resolution": "CIF"
      }
    }

"""
    serializer_classes = {
        'register_by_phone_number': RegistryByPhoneSerializer,
        'user_settings': UserSettingsSerializer,
    }

    def get_serializer(self, *args, **kwargs):
        serializer_class = kwargs.pop('serializer_class', None)
        if serializer_class is None:
            serializer_class = self.serializer_classes[self.action]
        kwargs['context'] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)

    permission_classes = (AllowAny,)
    throttle_classes = (AnonRateThrottle,)

    @action(detail=False, methods=('post',), permission_classes=(AllowAny,))
    def register_by_phone_number(self, request):

        # serializer = self.get_serializer(data=request.data)
        serializer = self.get_serializer(data=request.data)

        try:
            serializer.is_valid(raise_exception=True)
            # count limits for number and IP
            try:
                serializer.check_attemp(request)
            except RegistryByPhoneError as err:
                return Response({'errors': [f'{err}'], 'success': False})

            # send, check PIN code
            pin_step_result = serializer.registry_pin_step()
            if pin_step_result != 'phone was confirmed':
                return Response({'msg': pin_step_result, 'success': False}, status=status.HTTP_200_OK)

            # phone confirmed, create user
            else:
                user = serializer.create_user()

                token, created = Token.objects.get_or_create(user=user)
                resp_status = status.HTTP_201_CREATED

                return Response({'token': token.key, 'success': True, 'username': user.username}, status=resp_status)

        except ValidationError as e:
            return Response({'errors': [f'{error[0]}' for field, error in e.detail.items()],
                             'success': False})

    @action(detail=False, methods=('get',), permission_classes=(IsAuthenticated,))
    def me(self, request):
        return Response(request.user.full_info, status=status.HTTP_200_OK)

    @action(detail=False, methods=('get', 'post'), permission_classes=(IsAuthenticated,))
    def user_settings(self, request):

        user = request.user

        if request.method == 'GET':
            return Response({'id': user.pk, 'settings': user.info}, status=status.HTTP_200_OK)

        if request.method == 'POST':
            serializer = self.get_serializer(data=request.data)
            try:
                serializer.is_valid(raise_exception=True)
                user.user_info.update({'settings': serializer.validated_data['user_settings']})
                user.save()
                return Response({'ok'}, status=status.HTTP_200_OK)

            except ValidationError as e:
                return Response(
                    {'errors': [f'{error[0]}' for field, error in e.detail.items()],
                     'status': status.HTTP_400_BAD_REQUEST})


app_name = 'core'

router = DefaultRouter()
router.register(r'', TestApiViewSet, base_name='tests')
router.register(r'', DomofonUserViewSet, base_name='users')
router.register(r'', ChoicesViewSet, base_name='choices')

urlpatterns = [
    path('', include(router.urls)),
    path('api-token-auth', CustomAuthToken.as_view())
]
