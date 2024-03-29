FROM docker.io/library/python:3.10.6-alpine3.15 as build

# used by app to determine where the client-side code lives
ENV STATIC_PATH /app/app/static

# install uwsgi dependencies
RUN apk add python3-dev build-base linux-headers pcre-dev

# install requirements
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

FROM docker.io/library/python:3.10.6-alpine3.15 as base
COPY --from=build /root/.local /root/.local

# (re)installs a few dependencies
RUN apk add pcre-dev imagemagick

# load uwsgi config
RUN mkdir -p /etc/savour-pinoy-sushi
COPY ./etc/savour-pinoy-sushi.ini /etc/savour-pinoy-sushi

# install source code
COPY ./src /app/src

#############
# Development
#############

FROM base as dev

ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]

#############
# Testing
#############

FROM base as test
WORKDIR /app/savour-pinoy-sushi

# photo for testing
#COPY src/tests/test_data/photo.heic /mnt/data/

ENV IS_DOCKER 1
#RUN python -m unittest tests.integration

############
# Production
############

# mount image volumes here
RUN mkdir -p /mnt/media/
RUN mkdir -p /mnt/db/

FROM test as prod
WORKDIR /app/savour-pinoy-sushi

CMD ["/root/.local/bin/uwsgi", "--ini", "/etc/savour-pinoy-sushi/savour-pinoy-sushi.ini"]
