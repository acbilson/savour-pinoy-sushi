from django.shortcuts import render
from .models import LocationsWeekdays

# Create your views here.
def index(request):
    locations_weekdays = LocationsWeekdays.objects.all()
    context = {"locations_weekdays": locations_weekdays}
    return render(request, "locations/index.html", context)
