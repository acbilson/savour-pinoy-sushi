from django.shortcuts import render
from .models import LocationWeekday

# Create your views here.
def index(request):
    location_weekdays = LocationWeekday.objects.all()
    context = {"location_weekdays": location_weekdays}
    return render(request, "locations/index.html", context)
