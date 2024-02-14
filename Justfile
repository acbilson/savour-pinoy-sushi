set shell := ["/opt/homebrew/bin/fish", "-c"]

# starts a shell to run commands in context
shell:
	python src/manage.py shell

# runs a local development server
run:
	python src/manage.py runserver

# instantiates the database
init: migrate
	python src/manage.py createsuperuser --username acbilson --email acbilson@gmail.com
	sqlite3 src/db.sqlite3 < init/init.sql

# run to migrate database when models have changed
migrate:
	python src/manage.py migrate

# run to generate a new migration when another app is added
make_migration APP:
	python src/manage.py makemigrations {{ APP }}

# collect all static assets to STATIC_ROOT. Be sure you run this only when DEBUG = true
collect_static:
	python src/manage.py collectstatic

# adds a new app to the project
newapp APP:
	python src/manage.py startapp {{ APP }}

# builds a production image, running integration tests along the way
build:
  set COMMIT_ID (git rev-parse --short HEAD); \
  podman build \
  -t acbilson/savoy:latest \
  -t acbilson/savoy:$COMMIT_ID .

# clean up the prod directories
clean_prod:
	rm -rf mnt

# configures the local environment for production
init_prod: clean_prod
	mkdir -p mnt/{db,static,media}
	cp -f src/db.sqlite3 mnt/db/

# starts an nginx server to serve static and media assets
start_nginx:
  podman run --rm -d \
  --expose 5000 -p 5000:80 \
  -v /Users/alexbilson/source/savoy-pinot/mnt:/usr/share/nginx/html:ro \
  --name savoy-nginx \
  nginx:latest
  #-v /Users/alexbilson/source/savoy-pinot/media:/usr/share/nginx/html:ro \

# starts the production image
start: init_prod collect_static start_nginx
  # serves the savoy app
  podman run --rm \
  --expose 8000 -p 8000:8000 \
  -v /Users/alexbilson/source/savoy-pinot/mnt/db:/mnt/db \
  -v /Users/alexbilson/source/savoy-pinot/mnt/media:/mnt/media \
  --name savoy \
  acbilson/savoy:latest
