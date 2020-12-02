class User < ApplicationRecord
  enum status: {reader: 'reader', editor: 'editor', admin: 'admin'}

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def is_admin?
    status == 'admin'
  end

  # Try a Gravatar then fallback to initials avatar from https://ui-avatars.com/
  def avatar_url_or_default
    avatar_url || %Q{https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.to_s.downcase.strip)}?d=https%3A%2F%2Fui-avatars.com%2Fapi%2F/#{firstname}+#{lastname}/128}
  end
end