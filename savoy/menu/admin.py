from django.contrib import admin

# Register your models here.
from .models import MenuSection, MenuItem

admin.site.register(MenuSection)
admin.site.register(MenuItem)

