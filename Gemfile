source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 2.6.6'

# STOCK RAILS GEMS

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0.rc1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# GEMS FOR OUR APP

gem 'hamlit', '~> 2.13' # The HAML templating language for HTML files
gem 'view_component', '~> 2.22', require: 'view_component/engine' # Nice way to encapsulate view components and logic
gem 'omniauth-auth0', '~> 2.2' # Login to the app with Auth0.com
gem 'omniauth-rails_csrf_protection', '~> 0.1'
gem 'pagy', '~> 3.10' # Pagination
gem 'textacular', '~> 5.3' # Advanced search. pg_search gem is also good but more complex
gem 'good_job', '~> 1.3' # Background Jobs that dont require yet another dependancy like Redis
gem 'civil_service', '~> 2.3' # Service Objects (Command Pattern)
gem 'rails-settings-cached', '~> 2.3' # Central place for Settings and configurations for your app

gem 'avo', '~> 0.4' # Backend Admin to edit records in the DB

##--- gem for pubsub service ---##
# https://karolgalanciak.com/blog/2019/11/30/from-activerecord-callbacks-to-publish-slash-subscribe-pattern-and-event-driven-design/
gem 'wisper', '2.0.0'

gem 'rainbow' # Used to output colored text to the terminal logs
gem 'ruby-progressbar' # Used to display a progress bar in the terminal for long-running tasks
# If you want to get the master branch most current version direct from github you can do that like so...
# gem 'faker', github: 'faker-ruby/faker'
gem 'faker' # Used to create fake / test data in your DB
gem 'fabrication' # Used to create fake / test data in your DB
gem 'amazing_print' # For pretty printing objects / arrays to the terminal

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Call binding.pry anywhere in the code to get a Pry console
  gem 'pry-byebug'
  gem 'dotenv-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.0.3'
  gem 'listen', '~> 3.2'
  # # Display performance information such as SQL time and flame graphs for each request in your browser.
  # # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem 'rack-mini-profiler', '~> 2.0'
  # # For memory profiling
  # gem 'memory_profiler'

  # # For call-stack profiling flamegraphs
  # gem 'flamegraph'
  # gem 'stackprof'  
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  # Disabling this because https://avdi.codes/run-rails-6-system-tests-in-docker-using-a-host-browser/
  # gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
