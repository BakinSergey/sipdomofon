from core.synapse_db_fns import get_user_access_token
from django.shortcuts import render
from django.utils.decorators import method_decorator
from django.views.generic import RedirectView, View, TemplateView, UpdateView, FormView, CreateView
from django.http import HttpResponseRedirect, HttpResponseForbidden, JsonResponse, HttpResponse, Http404
from .decorators import anonymous_required
from django.contrib.auth import logout as auth_logout, login
from django.urls import reverse
from django.contrib.auth.mixins import PermissionRequiredMixin
from django.contrib.auth.views import redirect_to_login, LoginView
from django.core.exceptions import PermissionDenied


class PermissionMixin(PermissionRequiredMixin):
    raise_exception = True

    def handle_no_permission(self):
        if not self.request.user.is_authenticated():
            return redirect_to_login(self.request.get_full_path(), self.get_login_url(), self.get_redirect_field_name())
        if self.raise_exception:
            raise PermissionDenied(self.get_permission_denied_message())
        return redirect_to_login(self.request.get_full_path(), self.get_login_url(), self.get_redirect_field_name())


def logout(request):
    response = HttpResponseRedirect(reverse('login'))
    response.delete_cookie('synapse_token')

    return response


class DomofonLogin(LoginView):
    template_name = "registration/login.html"

    def dispatch(self, request, *args, **kwargs):
        userlogin = request.POST.get('username')
        is_synapser, token = get_user_access_token(userlogin)
        response = super(DomofonLogin, self).dispatch(request, *args, **kwargs)
        if is_synapser:
            response.set_cookie('synapse_token', token)

        return response


class IndexView(RedirectView):
    pattern_name = 'sipdomofon:index'
