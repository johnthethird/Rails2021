require_relative 'boot'

require 'rails'

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'

# Sprockets is dead. Long live Webpack.
# require "sprockets/railtie"
require 'rails/test_unit/railtie'
require 'good_job/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails2021
  class Application < Rails::Application
    config.application_name = Rails.application.class.module_parent_name

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.add_autoload_paths_to_load_path = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Sidekiq (popular Gem) uses Redis. No need for yet another dependancy, so lets use Postgres for our jobs
    config.active_job.queue_adapter = :good_job

    # I like SQL, so lets stay close to the metal here
    config.active_record.schema_format = :sql

    # Rack Deflate uses Zlib::GzipWriter to compress the body of your web page before responding to a request.
    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater

    # Rails 5.1 introduced CSRF tokens that change per-form.
    # Unfortunately there isn't an easy way to use them and use view caching at the same time.
    # Therefore we disable "per_form_csrf_tokens" for the time being.
    config.action_controller.per_form_csrf_tokens = false
  end
end
