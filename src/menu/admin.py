from django.contrib import admin
from .models import MenuSection, MenuItem

class MenuSectionAdmin(admin.ModelAdmin):
    list_display = ['display_txt', 'desc_txt', 'raw_disclaimer']

class MenuItemAdmin(admin.ModelAdmin):
    list_display = ['display_txt', 'desc_txt', 'price', 'section', 'raw_disclaimer']

admin.site.register(MenuSection, MenuSectionAdmin)
admin.site.register(MenuItem, MenuItemAdmin)

