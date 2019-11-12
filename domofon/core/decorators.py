from django.http import HttpResponseRedirect
from django.urls import reverse_lazy


def anonymous_required(view_function):
    return AnonymousRequired(view_function, reverse_lazy('home'))


class AnonymousRequired(object):
    def __init__(self, view_function, redirect_to):
        self.view_function = view_function
        self.redirect_to = redirect_to

    def __call__(self, request, *args, **kwargs):
        if request.user is not None and request.user.is_authenticated():
            return HttpResponseRedirect(self.redirect_to)
        return self.view_function(request, request.user, *args, **kwargs)
