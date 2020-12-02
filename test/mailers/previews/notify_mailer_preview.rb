class NotifyMailerPreview < ActionMailer::Preview
  def welcome_email
    NotifyMailer.with(user: User.first).welcome_email
  end
end