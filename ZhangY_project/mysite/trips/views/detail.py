import uuid
import json
from django.db import connection
from django.http import JsonResponse
from django.shortcuts import render

from mysite.middleware import jwt_exempt


@jwt_exempt
def detail_page(request, id):
    return render(request, 'trips/detail.html')


@jwt_exempt
def upload_image(request):
    try:
        image = request.FILES['image']
        image_name = str(uuid.uuid4()) + '.' + image.name.split('.')[-1]
        path = 'static/' + image_name
        with open(path, 'wb+') as destination:
            for chunk in image.chunks():
                destination.write(chunk)
        cursor = connection.cursor()
        cursor.execute('''insert into t_trip_images (trip_id, url) values (%s, %s)''',
                       (request.POST['id'], image_name,))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


@jwt_exempt
def get_image(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    cursor.execute('''select url from t_trip_images where trip_id = %s''', (body_data['id'],))
    rows = cursor.fetchall()
    res = []
    for i in rows:
        res.append({
            "url": i[0],
        })
    return JsonResponse({'data': res})


def itinerary(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    # cursor.execute('''SELECT a.id, name, group_concat(company), date_from, date_to
    # FROM t_trip a left join t_trip_company b
    # on a.id = b.trip_id where owner = %s group by a.id order by a.id desc''', (getUsername(),))
    cursor.callproc('get_itinerary', (body_data['id'],))
    rows = cursor.fetchall()
    res = []
    for i in rows:
        res.append({
            "date": i[0],
            "city": i[1],
        })
    return JsonResponse({"data": res})


def add_itinerary(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    # cursor.execute('''SELECT a.id, name, group_concat(company), date_from, date_to
    # FROM t_trip a left join t_trip_company b
    # on a.id = b.trip_id where owner = %s group by a.id order by a.id desc''', (getUsername(),))
    cursor.execute('''insert into t_trip_city (trip_id, city_id, date) values (%s, %s, %s)''',
                   (body_data['id'], body_data['city'], body_data['date'],))
    return JsonResponse({"code": 200})


def meals(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    # cursor.execute('''SELECT a.id, name, group_concat(company), date_from, date_to
    # FROM t_trip a left join t_trip_company b
    # on a.id = b.trip_id where owner = %s group by a.id order by a.id desc''', (getUsername(),))
    cursor.callproc('get_trip_meals', (body_data['id'],))
    rows = cursor.fetchall()
    res = []
    for i in rows:
        res.append({
            "date": i[0],
            "meal": i[1],
        })
    return JsonResponse({"data": res})


def add_meal(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    # cursor.execute('''SELECT a.id, name, group_concat(company), date_from, date_to
    # FROM t_trip a left join t_trip_company b
    # on a.id = b.trip_id where owner = %s group by a.id order by a.id desc''', (getUsername(),))
    cursor.execute('''insert into t_trip_meal (restaurant_id, date)''', (body_data['id'], body_data['date'],))
    return JsonResponse({"code": 200})
