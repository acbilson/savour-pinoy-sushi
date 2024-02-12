from django.shortcuts import render
from .models import MenuSection

# Create your views here.

def index(request):
    menu_sections = MenuSection.objects.all()
    context = {"menu_sections": menu_sections}
    return render(request, "menu/index.html", context)
