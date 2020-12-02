module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    # current_user is a method call, and as long as this module is included in a subclass of 
    # ApplicationRecord, it will have access to that method.
    if current_user.blank?
      redirect_to root_url, alert: "You must be logged in to access this page."
    end
  end
end