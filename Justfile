# Justfile https://github.com/casey/just

# List all recipies
default:
  @just --list

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
	docker-compose run --rm rails bin/rails {{CMD}}

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
	docker-compose exec -e DATABASE_URL=$TEST_DATABASE_URL -e RAILS_ENV=test -e PARALLEL_WORKERS=1 rails bin/rails test:system

# Docker-compose up (default is without worker)
up TARGETS='postgres rails webpacker':
	docker-compose up -d --remove-orphans {{TARGETS}}

# This allows you to put 'byebug' or 'binding.pry' in your Ruby code and get a debugger
attach:
	#!/usr/bin/env bash
	set -euxo pipefail
	docker attach $(docker-compose ps -q rails)	

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
	chromedriver --whitelisted-ips
