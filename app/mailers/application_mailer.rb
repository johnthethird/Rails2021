class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  default(
    from: -> { AppConfig.email_send_from },
    # Lets organize things a bit better by putting mailer templates in a views/mailers folder
    template_path: ->(mailer) { "mailers/#{mailer.class.name.underscore}" }
  )
end
