require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  parallelize(workers: 1)
  driven_by :selenium,
            using: :chrome,
            screen_size: [1400, 1400],
            options: { browser: :remote, url: 'http://host.docker.internal:9515' }
end
