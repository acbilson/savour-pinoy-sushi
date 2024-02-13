from django.contrib import admin
from .models import LocationStop, LocationWeekday

# Register your models here.

admin.site.register(LocationStop)
admin.site.register(LocationWeekday)
