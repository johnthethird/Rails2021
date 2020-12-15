# Justfile https://github.com/casey/just

COL_NORM   := `tput setaf 9`
COL_RED    := `tput setaf 1`
COL_GREEN  := `tput setaf 2`
COL_YELLOW := `tput setaf 3`
RAILS_CONTAINER := `docker-compose ps -q rails`

# List all recipies
default:
	@just --list

prettier:
	./node_modules/.bin/prettier --write '**/*.rb'
	
# Build the base Docker images
build-images:
	docker-compose build

# Run bundle install and yarn install (in parallel) inside the containers
setup-bundle-yarn:
	#!/usr/bin/env bash
	set -euxo pipefail
	docker-compose run --rm rails bash -c bin/bundle &
	docker-compose run --rm webpacker bash -c yarn

# Create and seed the database
setup-db:
	docker-compose run --rm rails bin/rails db:prepare db:seed

# Run a rails command like db:migrate inside the container
rails *CMD='-T':
	@# Using exec here so that we reuse the already running rails container for speed
	docker-compose exec rails bin/rails {{CMD}}

# Run bundle command inside container
bundle *CMD:
	docker-compose run --rm rails bin/bundle {{CMD}}

# Run yarn command inside container
yarn *CMD:
	docker-compose run --rm webpacker yarn {{CMD}}

# Run test command inside container
test *CMD:
	docker-compose exec -e DATABASE_URL=$TEST_DATABASE_URL -e RAILS_ENV=test rails bin/rails db:test:prepare test {{CMD}}

test-system:
	@echo "{{COL_YELLOW}}Make sure you ran the start-chromedriver recipie in another terminal window"
	docker-compose exec -e DATABASE_URL=$TEST_DATABASE_URL -e RAILS_ENV=test -e PARALLEL_WORKERS=1 rails bin/rails test:system

# Docker-compose up (default is without worker)
up TARGETS='postgres rails webpacker':
	docker-compose up -d --remove-orphans {{TARGETS}}
	@echo "{{COL_GREEN}}Go to http://localhost:3000 to view the app"

# This allows you to put 'byebug' or 'binding.pry' in your Ruby code and get a debugger
attach:
	docker attach {{RAILS_CONTAINER}}

# Logs for container
logs *TARGETS:
	@echo "Showing logs (Ctrl-C to exit)"
	docker-compose logs --tail=1000 --follow {{TARGETS}}

# Get a bash shell inside a running container
inspect TARGET='rails':
	docker-compose exec {{TARGET}} bash

# Docker-compose down (but keep volumes)
down:
	docker-compose down --remove-orphans

# Down and remove all Docker containers AND VOLUMES! (DB and caches will be deleted)
down-nuke-all:
  docker-compose down --remove-orphans -v

start-chromedriver:
	@echo "{{COL_YELLOW}}Chrome driver running, now you can run the test-system recipie in another terminal window"
	chromedriver --whitelisted-ips

# You can also run recipies in any interpreter, bash, ruby, python ,etc
# attach:
# 	#!/usr/bin/env bash
# 	set -euxo pipefail
# 	docker attach $(docker-compose ps -q rails)	
