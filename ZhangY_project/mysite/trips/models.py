# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
import jwt
from datetime import datetime, timedelta
from mysite.settings import SECRET_KEY


class TCity(models.Model):
    # id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=64)
    state = models.CharField(max_length=64)
    country = models.CharField(max_length=64)
    # create_time = models.DateTimeField()
    # update_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 't_city'
        unique_together = (('name', 'state', 'country'),)


class TRestaurant(models.Model):
    # id = models.IntegerField(primary_key=True)
    city = models.ForeignKey(TCity, models.DO_NOTHING)
    name = models.CharField(max_length=64)
    address = models.CharField(max_length=64)
    cuisine = models.CharField(max_length=64)
    # create_time = models.DateTimeField()
    # update_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 't_restaurant'
        unique_together = (('city', 'address'),)


class TTrip(models.Model):
    # id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=64)
    owner = models.ForeignKey('TUser', models.DO_NOTHING, db_column='owner', to_field='username')
    date_from = models.DateTimeField()
    date_to = models.DateTimeField()
    # create_time = models.DateTimeField()
    # update_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 't_trip'


class TTripCity(models.Model):
    # id = models.IntegerField(primary_key=True)
    trip = models.ForeignKey(TTrip, models.DO_NOTHING)
    city = models.ForeignKey(TCity, models.DO_NOTHING)
    # create_time = models.DateTimeField()
    # update_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 't_trip_city'
        unique_together = (('trip', 'city'),)


class TTripCompany(models.Model):
    # id = models.IntegerField(primary_key=True)
    trip = models.ForeignKey(TTrip, models.DO_NOTHING)
    company = models.ForeignKey('TUser', models.DO_NOTHING, db_column='company', to_field='username')
    # create_time = models.DateTimeField()
    # update_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 't_trip_company'
        unique_together = (('trip', 'company'),)


class TTripMeal(models.Model):
    # id = models.IntegerField(primary_key=True)
    trip = models.ForeignKey(TTrip, models.DO_NOTHING)
    restaurant = models.ForeignKey(TRestaurant, models.DO_NOTHING)
    review = models.CharField(max_length=64)
    eat_time = models.DateTimeField()
    # create_time = models.DateTimeField()
    # update_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 't_trip_meal'


class TUser(models.Model):
    # id = models.IntegerField(primary_key=True)
    email = models.CharField(unique=True, max_length=64)
    username = models.CharField(unique=True, max_length=64)
    password = models.CharField(max_length=64)
    # create_time = models.DateTimeField()
    # update_time = models.DateTimeField()

    @property
    def token(self):
        return self._generate_jwt_token()

    def _generate_jwt_token(self):
        """
        Generates a JSON Web Token that stores this user's ID and has an expiry
        date set to 7 days into the future.
        """
        return jwt.encode({
            'id': self.username,
            'exp': int((datetime.now() + timedelta(days=7)).strftime('%s'))
        }, SECRET_KEY, algorithm='HS256')

    class Meta:
        managed = False
        db_table = 't_user'