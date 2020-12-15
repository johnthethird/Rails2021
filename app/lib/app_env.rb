# Central place to specify exactly which ENV vars we need to run the app
class AppEnv
  REQUIRED_KEYS = %w[SECRET_KEY_BASE DATABASE_URL AUTH0_DOMAIN AUTH0_CLIENT_ID AUTH0_CLIENT_SECRET].freeze

  OPTIONAL_KEYS = %w[RAILS_SERVE_STATIC_FILES].freeze

  def self.ensure!
    missing_required_keys = REQUIRED_KEYS - ENV.keys
    unless missing_required_keys.empty?
      if Rails.env.production?
        abort Rainbow("FATAL ERROR! Missing ENV variables #{missing_required_keys.join(',')}").red
      else
        Rails.logger.warn Rainbow('WARNING:').red + ' Missing ENV variables ' +
                            Rainbow(missing_required_keys.join(',')).red +
                            '. Not all keys are necessary in development. Any features that depend on this key will not work.'
      end
    end

    missing_optional_keys = OPTIONAL_KEYS - ENV.keys
    unless missing_optional_keys.empty?
      Rails.logger.info Rainbow(
                          "Missing optional ENV variables #{
                            missing_optional_keys.join(',')
                          }. Any features that depend on these keys will not work."
                        ).yellow
    end
  end

  def self.[](key)
    if ENV.key?(key)
      ENV[key]
    else
      Rails.logger.debug("💣 Unset ENV variable: #{key}")
      nil
    end
  end
end
