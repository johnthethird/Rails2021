# Some weird bug or something causes Auth0 login to fail, so just turn this off.
# https://github.com/rails/rails/issues/24257
Rails.application.config.action_controller.per_form_csrf_tokens = false

# Newer Rails versions uses a Credentials system for secrets, but I prefer the old skool ENV way of doing things.
Rails.application.config.secret_key_base = ENV.fetch('SECRET_KEY_BASE')

# Dump schema to db/structure.sql instead of a Ruby format.
Rails.application.config.active_record.schema_format = :sql

# Get rid of annoying license check for Avo
# https://github.com/avo-hq/avo/blob/b71062b104/lib/avo/app/app.rb#L34
ActiveSupport::Reloader.to_prepare do
  module Avo
    class App
      class << self
        def init(current_request = nil)
          init_resources
          @@license = LicenseManager.new({"id" => "community"}).license
        end
      end
    end
  end
end