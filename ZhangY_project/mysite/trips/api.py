from django.urls import path

from . import views

urlpatterns = [
    path('login', views.login),
    path('register', views.register),
    path('users', views.users),
    path('trips', views.trips),
    path('tripsPart', views.trips_part),
    path('addTrip', views.add_trip),
    path('updateTrip', views.update_trip),
    path('deleteTrip', views.delete_trip),
    path('cities', views.get_cities),
    path('addCity', views.add_city),
    path('deleteCity', views.delete_city),
    path('updateCity', views.update_city),
    path('ress', views.get_ress),
    path('addRes', views.add_res),
    path('deleteRes', views.delete_res),
    path('updateRes', views.update_res),
    path('uploadImage', views.upload_image),
    path('getImage', views.get_image),
    path('itinerary', views.itinerary),
    path('addItinerary', views.add_itinerary),
    path('meals', views.meals),
    path('addMeal', views.add_meal),
]
