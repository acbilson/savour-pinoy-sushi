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
RUN apk add pcre-dev

# load uwsgi config
RUN mkdir -p /etc/savoy
COPY ./etc/savoy.ini /etc/savoy

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
WORKDIR /app/savoy

# photo for testing
#COPY src/tests/test_data/photo.heic /mnt/data/

ENV IS_DOCKER 1
#RUN python -m unittest tests.integration

############
# Production
############

# TODO: run migrations and user configuration here

FROM test as prod
WORKDIR /app/savoy

CMD ["/root/.local/bin/uwsgi", "--ini", "/etc/savoy/savoy.ini"]
