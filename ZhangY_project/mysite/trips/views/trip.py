import json
from django.db import connection
from django.http import JsonResponse
from django.shortcuts import render

from mysite.middleware import getUsername
from mysite.middleware import jwt_exempt


@jwt_exempt
def trips_page(request):
    return render(request, 'trips/trips.html')


@jwt_exempt
def cities_page(request):
    return render(request, 'trips/cities.html')


def trips(request):
    cursor = connection.cursor()
    # cursor.execute('''SELECT a.id, name, group_concat(company), date_from, date_to
    # FROM t_trip a left join t_trip_company b
    # on a.id = b.trip_id where owner = %s group by a.id order by a.id desc''', (getUsername(),))
    cursor.callproc('get_my_trips', (getUsername(),))
    rows = cursor.fetchall()
    res = []
    for i in rows:
        res.append({
            "id": i[0],
            "name": i[1],
            "companies": i[2],
            "date_from": i[3],
            "date_to": i[4],
        })
    return JsonResponse({"data": res})


def trips_part(request):
    cursor = connection.cursor()
    # cursor.execute('''SELECT a.id, name, group_concat(company), date_from, date_to
    # FROM t_trip a join t_trip_company b
    # on a.id = b.trip_id and a.id in (select trip_id from t_trip_company where company = %s)
    # group by a.id order by a.id desc''', (getUsername(),))
    cursor.callproc('get_my_part_trips', (getUsername(),))
    rows = cursor.fetchall()
    res = []
    for i in rows:
        res.append({
            "id": i[0],
            "name": i[1],
            "companies": i[2],
            "date_from": i[3],
            "date_to": i[4],
        })
    return JsonResponse({"data": res})


def delete_trip(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    try:
        cursor.execute('''delete from t_trip where id = %s''', (body_data['id'],))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


def add_trip(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    try:
        trip_companies = []
        if body_data['companiesArr']:
            for i in body_data['companiesArr']:
                if i != getUsername():
                    trip_companies.append(i)
        cursor.callproc('insert_trip', ((body_data['name'], getUsername(),
                                         body_data['date_from'], body_data['date_to'],
                                         ','.join(trip_companies) + ',' if len(trip_companies) > 0 else '',)))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


def update_trip(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    try:
        trip_companies = []
        if body_data['companiesArr']:
            for i in body_data['companiesArr']:
                if i != getUsername():
                    trip_companies.append(i)
        print(body_data['id'])
        cursor.callproc('update_trip', ((body_data['id'], body_data['name'], body_data['date_from'], body_data['date_to'],
                                         ','.join(trip_companies) + ',' if len(trip_companies) > 0 else '',)))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


@jwt_exempt
def get_cities(request):
    cursor = connection.cursor()
    # TODO order by ???
    cursor.execute('''SELECT id, name, state, country FROM t_city order by id desc''')
    rows = cursor.fetchall()
    res = []
    for i in rows:
        res.append({
            "id": i[0],
            "name": i[1],
            "state": i[2],
            "country": i[3],
        })
    return JsonResponse({"data": res})


@jwt_exempt
def add_city(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    try:
        cursor.execute('''insert into t_city (name, state, country) values (%s, %s, %s)''',
                       (body_data['name'], body_data['state'], body_data['country'],))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


@jwt_exempt
def delete_city(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    try:
        cursor.execute('''delete from t_city where id = %s''', (body_data['id'],))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


@jwt_exempt
def update_city(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    try:
        cursor.execute('''update t_city set name = %s, state = %s, country = %s where id = %s''',
                       (body_data['name'], body_data['state'], body_data['country'], body_data['id'],))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


@jwt_exempt
def get_ress(request):
    cursor = connection.cursor()
    # TODO order by ???
    # cursor.execute('''SELECT a.id, b.name, a.name, address, cuisine
    # FROM t_restaurant a join t_city b
    # on a. city_id = b.id
    # order by a.id desc''')
    cursor.callproc('get_ress')
    rows = cursor.fetchall()
    res = []
    for i in rows:
        res.append({
            "id": i[0],
            "city": i[1],
            "name": i[2],
            "address": i[3],
            "cuisine": i[4],
        })
    return JsonResponse({"data": res})


@jwt_exempt
def add_res(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    try:
        cursor.execute('''insert into t_restaurant (city_id, name, address, cuisine) values (%s, %s, %s, %s)''',
                       (body_data['city'], body_data['name'], body_data['address'], body_data['cuisine'],))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


@jwt_exempt
def delete_res(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    try:
        cursor.execute('''delete from t_restaurant where id = %s''', (body_data['id'],))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})


@jwt_exempt
def update_res(request):
    body_unicode = request.body.decode('utf-8')
    body_data = json.loads(body_unicode)
    cursor = connection.cursor()
    try:
        cursor.execute('''update t_restaurant set city_id = %s, name = %s, address = %s, cuisine = %s where id = %s''',
                       (body_data['city'], body_data['name'], body_data['address'], body_data['cuisine'],
                        body_data['id'],))
    except:
        return JsonResponse({'code': 50000})
    return JsonResponse({'code': 200})
