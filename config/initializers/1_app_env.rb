require_relative '../../app/lib/app_env'

# Check the env is setup properly, except when running Rake tasks its not strictly necessary
AppEnv.ensure! unless $rails_rake_task
