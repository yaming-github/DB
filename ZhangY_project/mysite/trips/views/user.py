from django.shortcuts import render
from django.http import JsonResponse
from django.db import connection
from trips.models import TUser
import json
from mysite.middleware import jwt_exempt


@jwt_exempt
def login_page(request):
    return render(request, 'trips/login.html')


@jwt_exempt
def login(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    try:
        user = TUser.objects.get(username=body_data['username'], password=body_data['password'])
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200, 'token': user.token})


@jwt_exempt
def register(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    try:
        user = TUser(email=body_data['email'], username=body_data['username'], password=body_data['password'])
        user.save()
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


def users(request):
    cursor = connection.cursor()
    cursor.execute('''SELECT id, username from t_user''')
    rows = cursor.fetchall()
    res = []
    for i in rows:
        res.append({
            "id": i[0],
            "username": i[1],
        })
    return JsonResponse({"data": res})
