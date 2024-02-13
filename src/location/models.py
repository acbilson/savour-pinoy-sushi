from django.db import models

WEEKDAYS = {
    "SAT": "Saturday",
    "SUN": "Sunday",
    "MON": "Monday",
    "TUE": "Tuesday",
    "WED": "Wednesday",
    "THU": "Thursday",
    "FRI": "Friday",
}

class LocationWeekday(models.Model):
    weekday_txt = models.CharField(max_length=3, choices=WEEKDAYS)

    def __str__(self):
        return self.weekday_txt

# Create your models here.
class LocationStop(models.Model):
    # an admin-only identifier for the stop
    name_txt = models.CharField(max_length=200)

    # the stop's name on the website
    display_txt = models.CharField(max_length=200)

    # a selection of one ore more days that the food
    # truck is at this stop
    weekdays = models.ManyToManyField(LocationWeekday)

    # the hours that the food truck is at this stop
    hours_txt = models.CharField(max_length=200)

    def __str__(self):
        return self.name_txt
