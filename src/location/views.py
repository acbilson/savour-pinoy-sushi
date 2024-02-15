from datetime import date, timedelta
from django.shortcuts import render
from .models import LocationStop, LocationSetting


# Create your views here.
def index(request):
    settings = LocationSetting.objects.first()
    days_back = str(date.today() - timedelta(days=settings.display_days_back))
    location_locationstops = (LocationStop.objects
                              .filter(stop_dt__gte=days_back)
                              .order_by("-stop_dt"))
    stops = []
    for stop in location_locationstops:
        stops.append({ "date": stop.stop_dt.strftime("%A, %d %b"), "hours": stop.hours_txt, "location": stop.location.display_txt, "address": stop.location.addr_txt })

    print(location_locationstops)
    print(stops)

    context = {"stops": stops }
    return render(request, "locations/index.html", context)
