"""domofon URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.conf import settings
from django.conf.urls import url, include
from django.conf.urls.static import static

from django.urls import path
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.contrib.staticfiles.urls import staticfiles_urlpatterns

from django.contrib.staticfiles.views import serve
from django.views.decorators.cache import never_cache
from django.contrib.auth.decorators import login_required

from core import views
from rest_framework.throttling import BaseThrottle

from rest_framework_swagger.views import get_swagger_view

class AlwaysRateThrottle(BaseThrottle):
    def allow_request(self, request, view):
        return True


schema_view = get_swagger_view(title='SipDomofon API', )



urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.IndexView.as_view(), name="home"),
    path('login/', views.DomofonLogin.as_view(), name="login"),
    path('logout/', views.logout, name="logout"),
    path('reset-password/', auth_views.PasswordResetView.as_view(), name="password_reset"),
    path('reset-password-done/', auth_views.PasswordResetDoneView.as_view(), name="password_reset_done"),
    path('change-password/', auth_views.PasswordChangeView.as_view(), name="password_change"),
    path('change-password-done/', auth_views.PasswordChangeDoneView.as_view(), name="password_change_done"),
    url('^reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>[0-9A-Za-z]{1,13}-[0-9A-Za-z]{1,20})/$',
        auth_views.PasswordResetConfirmView.as_view(), name="password_reset_confirm"),
    path('reset-done/', auth_views.PasswordResetCompleteView.as_view(), name="password_reset_complete"),

    path('sipdomofon/', include("sipdomofon.urls", namespace="sipdomofon")),

    path('api/',  schema_view, name="schema_view"),
    path('api/', include('core.api', namespace="core")),

]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += staticfiles_urlpatterns()
    urlpatterns.append(path('static/<path:path>', never_cache(serve)))
