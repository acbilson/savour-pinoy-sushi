set dotenv-load
set shell := ["/opt/homebrew/bin/fish", "-c"]

# starts a shell to run commands in context
shell:
	python src/manage.py shell

# runs a local development server
run:
	set -x DJANGO_DEBUG True
	python src/manage.py runserver

# instantiates the database
init_db: migrate
	python src/manage.py createsuperuser --username acbilson --email acbilson@gmail.com
	sqlite3 src/db.sqlite3 < init/init.sql

# run to migrate database when models have changed
migrate:
	python src/manage.py migrate

# run to generate a new migration when another app is added
make_migration APP:
	python src/manage.py makemigrations {{ APP }}

# collect all static assets to STATIC_ROOT
[private]
collect_static:
	set -x DJANGO_DEBUG True
	python src/manage.py collectstatic --no-input

# adds a new app to the project
newapp APP:
	python src/manage.py startapp {{ APP }}

# builds a production image
build: clean
  set COMMIT_ID (git rev-parse --short HEAD); \
  podman build \
  -t acbilson/savour-pinoy-sushi:latest \
  -t acbilson/savour-pinoy-sushi:$COMMIT_ID .

# clean up mnt and dbg directories
clean:
	rm -rf mnt
	rm -rf src/dbg
	rm -rf prd

# configures the local environment for production
[private]
init_prod: clean collect_static
	mkdir -p mnt/{db,media}
	cp -f src/db.sqlite3 mnt/db/
	cp -r src/dbg/static mnt/static

# starts an nginx server to serve static and media assets
[private]
start_nginx:
  podman run --rm -d \
  --expose 5000 -p 5000:80 \
  -v /Users/alexbilson/source/savour-pinoy-sushi-pinot/mnt:/usr/share/nginx/html:ro \
  --name savour-pinoy-sushi-nginx \
  nginx:latest

# starts the production image
[private]
start_savour-pinoy-sushi: init_prod
  podman run --rm \
  --expose 8000 -p 8000:80 \
  -v /Users/alexbilson/source/savour-pinoy-sushi-pinot/mnt/db:/mnt/db \
  -v /Users/alexbilson/source/savour-pinoy-sushi-pinot/mnt/media:/mnt/media \
  -e DJANGO_DEBUG=False \
  -e DJANGO_SESSION_SECRET=$DJANGO_SESSION_SECRET \
  -e DJANGO_HOST=$DJANGO_HOST_PRD \
  -e DJANGO_STATIC_ROOT=$DJANGO_STATIC_ROOT_PRD \
  -e DJANGO_MEDIA_ROOT=$DJANGO_MEDIA_ROOT_PRD \
  -e DJANGO_STATIC_URL=$DJANGO_STATIC_URL_PRD \
  -e DJANGO_MEDIA_URL=$DJANGO_MEDIA_URL_PRD \
  -e DJANGO_DB_ROOT=$DJANGO_DB_ROOT_PRD \
  --name savour-pinoy-sushi \
  acbilson/savour-pinoy-sushi:latest

# starts the production image with nginx server
start: start_nginx start_savour-pinoy-sushi
  podman run --rm \
  --expose 8000 -p 8000:80 \
  -v /Users/alexbilson/source/savour-pinoy-sushi-pinot/mnt/db:/mnt/db \
  -v /Users/alexbilson/source/savour-pinoy-sushi-pinot/mnt/media:/mnt/media \
  -e DJANGO_DEBUG=False \
  -e DJANGO_SESSION_SECRET=$DJANGO_SESSION_SECRET \
  -e DJANGO_HOST=$DJANGO_HOST_PRD \
  -e DJANGO_STATIC_ROOT=$DJANGO_STATIC_ROOT_PRD \
  -e DJANGO_MEDIA_ROOT=$DJANGO_MEDIA_ROOT_PRD \
  -e DJANGO_STATIC_URL=$DJANGO_STATIC_URL_PRD \
  -e DJANGO_MEDIA_URL=$DJANGO_MEDIA_URL_PRD \
  -e DJANGO_DB_ROOT=$DJANGO_DB_ROOT_PRD \
  --name savour-pinoy-sushi \
  acbilson/savour-pinoy-sushi:latest

# configures the local environment for deployment. DOES NOT SEND ADMIN FILES
[private]
init_deploy: clean collect_static
	mkdir -p prd/static
	cp -r src/dbg/static/{css,menu,home,location} prd/static/
	scp -r prd/static vultr:/srv/savour-pinoy-sushi

# runs a simple ansible ad-hoc command to test the connection
test-connection:
	ansible -i ansible/prod.ini --vault-password-file=ansible/.vault_pass -u abilson vultr -m ping

# edits the encrypted ansible group variables
edit-vault:
	ansible-vault edit --vault-password-file=ansible/.vault_pass ansible/group_vars/web/vault.yml

# runs the ansible deployment playbook
deploy: init_deploy
	ansible-playbook -i ansible/prod.ini --vault-password-file=ansible/.vault_pass --skip-tags onetime ansible/deploy.yml

# redeploys the image
redeploy: init_deploy
	ansible-playbook -i ansible/prod.ini --vault-password-file=ansible/.vault_pass --skip-tags onetime ansible/redeploy.yml
