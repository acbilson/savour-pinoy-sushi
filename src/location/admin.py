from django.contrib import admin
from .models import LocationStop, LocationDestination, LocationSetting

class LocationStopAdmin(admin.ModelAdmin):
    list_display = ['stop_dt', 'hours_txt', 'location', 'filtered_by_days_back' ]

class LocationDestinationAdmin(admin.ModelAdmin):
    list_display = ['display_txt', 'addr_txt']

class LocationSettingAdmin(admin.ModelAdmin):
    def has_add_permission(self, request):
        return False

    def has_delete_permission(self, request, obj=None):
        return False

# Register your models here.
admin.site.register(LocationStop, LocationStopAdmin)
admin.site.register(LocationDestination, LocationDestinationAdmin)
admin.site.register(LocationSetting, LocationSettingAdmin)
