from django.db import models

# Create your models here.
class LocationsStops(models.Model):
    location_txt = models.CharField(max_length=200)
    hours_txt = models.CharField(max_length=200)

    def __str__(self):
        return self.location_txt

class LocationsWeekdays(models.Model):
    weekday_txt = models.CharField(max_length=100)
    stops = models.ManyToManyField(LocationsStops)

    def __str__(self):
        return self.weekday_txt
