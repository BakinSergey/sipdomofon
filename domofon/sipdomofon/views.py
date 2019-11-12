from django.shortcuts import render
from django.views.generic import TemplateView
from django.contrib.auth.mixins import LoginRequiredMixin, PermissionRequiredMixin
from django.views.generic.base import View
from core.views import PermissionMixin


class HomeView(LoginRequiredMixin, View):
    def get(self, request, *args, **kwargs):
        user_roles = request.user.get_roles()
        context = {'greeting_message': 'Welcome to SIP domofon project!',
                   'api_user': any(set(user_roles) & {'support', 'admin'})
                   }
        return render(request, template_name='sipdomofon/index.html', context=context)
