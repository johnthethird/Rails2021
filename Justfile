# Justfile https://github.com/casey/just

# List all recipies
default:
  @just --list

# Run a rails command like db:migrate inside the Docker container
rails cmd:
	docker-compose run --rm rails bin/rails "{{cmd}}"

# Get a Bash prompt inside the rails container
bash:
	docker-compose run --rm rails bash

# Build the base Docker images
build-images:
	docker-compose build --parallel

# Run bundle install and yarn install (in parallel) inside the containers
setup-bundle-yarn:
	#!/usr/bin/env bash
	set -euxo pipefail
	docker-compose run --rm rails bash -c bin/bundle &
	docker-compose run --rm webpacker bash -c yarn

# Create and seed the database
setup-db:
	docker-compose run --rm rails bin/rails db:prepare db:seed

# Docker-compose up (default is without worker)
up targets='postgres rails webpacker':
	docker-compose up -d --remove-orphans {{targets}}

# This allows you to put 'byebug' in your Ruby code and get a debugger
attach:
	#!/usr/bin/env bash
	set -euxo pipefail
	docker attach $(docker-compose ps -q rails)	

logs targets='':
	docker-compose logs --tail=1000 -f {{targets}}

exec target='rails':
	docker-compose exec {{target}} bash

# Docker-compose down (but keep volumes)
down:
	docker-compose down --remove-orphans

# Down and remove all Docker containers AND VOLUMES!
down-nuke-all:
  docker-compose down --remove-orphans -v

