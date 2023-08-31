from django.urls import path

from . import views

urlpatterns = [
    path('', views.login_page),
    path('trips', views.trips_page),
    path('cities', views.cities_page),
    path('detail/<id>', views.detail_page),
]
