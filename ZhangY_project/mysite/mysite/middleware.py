from functools import wraps
from django.http import HttpResponse, JsonResponse
import jwt
import json
from .settings import SECRET_KEY
from trips.error import *

username = ''


class JWTMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        # One-time configuration and initialization.

    def __call__(self, request):
        # Code to be executed for each request before
        # the view (and later middleware) are called.

        response = self.get_response(request)

        # Code to be executed for each request/response after
        # the view is called.

        return response

    def process_view(self, request, view_func, view_args, view_kwargs):
        if getattr(view_func, "jwt_exempt", False):
            return None
        try:
            token = request.headers['token']
        except:
            return JsonResponse({'code': UNAUTHORIZED, 'message': error_str[UNAUTHORIZED]})

        try:
            payload = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])
        except:
            return JsonResponse({'code': UNAUTHORIZED, 'message': error_str[UNAUTHORIZED]})

        global username
        username = payload['id']
        return None


def jwt_exempt(view_func):
    """Mark a view function as being exempt from the JWT view protection."""

    # view_func.csrf_exempt = True would also work, but decorators are nicer
    # if they don't have side effects, so return a new function.
    def wrapped_view(*args, **kwargs):
        return view_func(*args, **kwargs)

    wrapped_view.jwt_exempt = True
    return wraps(view_func)(wrapped_view)


class ErrorHandlerMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        # One-time configuration and initialization.

    def __call__(self, request):
        # Code to be executed for each request before
        # the view (and later middleware) are called.
        try:
            response = self.get_response(request)
        except InternalError as e:
            print(e)
            return JsonResponse({'code': e.code, 'message': e.message})

        # Code to be executed for each request/response after
        # the view is called.
        if 'code' in json.loads(response.content) and json.loads(response.content)['code'] == UNAUTHORIZED:
            return response

        return JsonResponse({'code': OK, 'message': error_str[OK],
                             'data': json.loads(response.content)})


def getUsername():
    return username
