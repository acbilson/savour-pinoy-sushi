set shell := ["/opt/homebrew/bin/fish", "-c"]

# runs a local development server
run:
	python src/manage.py runserver

# run to migrate database when models have changed
migrate:
	python src/manage.py migrate

# run to generate a new migration when another app is added
make_migration APP:
	python src/manage.py makemigration {{ APP }}

# builds a production image, running integration tests along the way
build:
  set COMMIT_ID (git rev-parse --short HEAD); \
  podman build \
  -t acbilson/savoy:latest \
  -t acbilson/savoy:$COMMIT_ID .

# starts the production image
start:
  podman run --rm \
  --expose 8000 -p 8000:8000 \
  --name savoy \
  acbilson/savoy:latest

