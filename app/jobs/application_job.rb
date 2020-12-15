class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Retry failed jobs that throw StandardError
  retry_on StandardError, wait: :exponentially_longer, attempts: 10

  # Most jobs are safe to ignore if the underlying records are no longer available
  discard_on ActiveJob::DeserializationError

  # If you want to set a job timeout, you can say this
  # JobTimeoutError = Class.new(StandardError)

  # around_perform do |_job, block|
  #   # Timeout jobs after 10 minutes
  #   Timeout.timeout(10.minutes, JobTimeoutError) do
  #     block.call
  #   end
  # end

  # https://github.com/steveklabnik/request_store/issues/65
  before_perform { RequestStore.clear! }
end
