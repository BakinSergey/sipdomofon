# -*- coding: utf-8 -*-
from __future__ import absolute_import

from django.conf.urls import url
from django.urls import path

from . import views

app_name = 'core'

urlpatterns = [
    path(r'', views.IndexView.as_view(), name="index"),
]
