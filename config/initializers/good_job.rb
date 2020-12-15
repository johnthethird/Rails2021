# Good Job config can be tweaked here

# This would send any errors when running jobs to an external service like https://sentry.io
# GoodJob.on_thread_error = -> (exception) { Raven.capture_exception(exception) }

# Keep job records in DB so we can inspect them. We also then need to clean out the table
# every once in a while with something like this command in a Rake task: GoodJob::Job.finished(7.days.ago).delete_all
GoodJob.preserve_job_records = true

# Tell GoodJob to not retry, because we retry in ApplicationJob class already
GoodJob.retry_on_unhandled_error = false
