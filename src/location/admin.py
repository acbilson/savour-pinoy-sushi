from django.contrib import admin
from .models import LocationStop, LocationDestination, LocationSetting

# Register your models here.
admin.site.register(LocationStop)
admin.site.register(LocationDestination)
admin.site.register(LocationSetting)
