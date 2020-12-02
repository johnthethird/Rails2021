class NotifyMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    subject = "Welcome to #{AppConfig.app_name}"
    mail(to: @user.email, subject: subject)
  end

end