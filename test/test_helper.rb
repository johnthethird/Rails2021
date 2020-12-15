ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

abort('The Rails environment is running in production mode!') if Rails.env.production?

ActiveRecord::Migration.maintain_test_schema!

# Use `fetch` to fail loudly if these variables aren't set.
Capybara.server_host = ENV.fetch('CAPYBARA_SERVER_HOST')
Capybara.server_port = ENV.fetch('CAPYBARA_SERVER_PORT')

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def login_as(user)
    get "/auth/login_as?user_id=#{user.id}"
  end
end
