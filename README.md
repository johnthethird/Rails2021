[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/johnthethird/Rails2021)

# Rails 2021

This is a Rails app, with my favorite Gems and ways of doing things. Use it as a base to get started on your own app!

## Live Demo

Check it out at Heroku https://rails2021.herokuapp.com/

## Technologies Used

- Based on Ruby 2.7, Rails 6.1 (beta) and Postgres 13
- Docker-based development, including ability to run systems tests in container controlling a browser outside the container (Thanks [Avdi](https://dev.to/avdi/rails-6-system-tests-from-top-to-bottom-28g7)!)
- Remove Sprockets (legacy asset pipeline)
- Redo the stock Rails 6 file system structure so that there is a `frontend` directory, with all JS and CSS in it, served by Webpack
- Use [Auth0](https://github.com/auth0/omniauth-auth0) for user logins. Allows for using Google to log in to our site.
- Use [HAML](https://haml.info/tutorial.html) as a better way to write HTML
- Use [Bulma](https://bulma.io) as a CSS framework to build on
- Use [AlpineJS](https://github.com/alpinejs/alpine/) and [HTMX](https://htmx.org) as lightweight, easy ways to do Javascript things.
- Use [Good Job](https://github.com/bensheldon/good_job) for background jobs, which uses your existing Postgres DB instead of adding another runtime dependancy like Redis.
- Use [Civil Service](https://github.com/actblue/civil_service) gem for interactors (Command Pattern)
- Use [Avo](https://docs.avohq.io) for a backend administration system
- Use [Rails Settings Cached](https://github.com/huacnlee/rails-settings-cached) for application configuration settings
- Use [Textacular](http://textacular.github.io/textacular/) for lightweight Postgres-native full text search
- Use [Dotenv](https://github.com/bkeepers/dotenv) for storing API keys etc, instead of stock Rails Credentials.

## Installation

This repo is built to be Docker-friendly in development. All you need is Docker and docker-compose installed, and you can get the app up and running. We are using the awesome CLI program [Just](https://github.com/casey/just) as a command runner, so you don't have to remember all those long docker-compose commands.

- Install [Just](https://github.com/casey/just) for your platform (Linux/OSX/Windows)
- Type `just` to see a list of all available commands, which live in the Justfile in the root directory

- `just build-images` will build the Docker image for the rails app, webpacker, and Postgres
- `just up` will start everything up
- `just setup-bundle-yarn` will install all necessary gems and npm packages inside the containers
- `just setup-db` will create and initialize the database

Now we are ready to start developing. When you want to run a `rails` command, like `rails routes` or `rails g migration CreateFancyTable`, you would instead run `just rails routes` or `just rails g migration CreateFancyTable`. The Justfile will translate into docker-ese and run the rails command inside the container. To run your tests, its `just test` which takes care of setting the required ENV vars and then runs your tests.

## Debugging

Since we are running our Rails app inside a detached container, if we put `binding.pry` in our code, we will have no way to interact with it like we normally would. But, you can run `just attach` and you will be attached to the running rails server container, and will then be able to interact with the debugger.
