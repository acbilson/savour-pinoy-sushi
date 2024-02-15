from django.db import models


class LocationSetting(models.Model):

    # number of days to display in the past
    display_days_back = models.IntegerField()

    def __str__(self):
        return 'Location Settings'

class LocationDestination(models.Model):
    # the location's name on the website
    display_txt = models.CharField(max_length=100)

    # the location's address on the website
    addr_txt = models.CharField(max_length=200)

    def __str__(self):
        return self.display_txt


class LocationStop(models.Model):
    # when the truck will be at this location
    stop_dt = models.DateField()

    # the hours that the food truck is at this stop
    hours_txt = models.CharField(max_length=100)

    # where the truck will be located
    location = models.ForeignKey(LocationDestination, on_delete=models.CASCADE)


    def __str__(self):
        return f"{str(self.location)} on {self.stop_dt}"
