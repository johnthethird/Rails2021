class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action do
    if Rails.env.development?
      # Write out the session object to the log for debugging
      # "ap" is "amazing print" gem, which nicely formats whatever you print out
      puts "👁 Debug Info"
      ap({
        request_via_turbolinks: request.headers["Turbolinks-Referrer"].present?,
        request_via_htmx: htmx?,
        current_path: current_path,
        request_params: request.params,
        session: session
      }, indent: -2, index: false)
      # If you turn on profiling you can say this so that only logged in admins can profile pages
      # if current_user && current_user.is_admin?
      #   Rack::MiniProfiler.authorize_request
      # end
    end
  end

  def is_admin?
    is_logged_in? && current_user.is_admin?
  end
  helper_method :is_admin?

  def is_logged_in?
    current_user.present?
  end
  helper_method :is_logged_in?

  def current_user
    @current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
  end
  helper_method :current_user # Now you can call this method in any view

  def current_path
    @current_path ||= request.env['PATH_INFO']
  end
  helper_method :current_path

  def htmx?
    request.headers['HX-Request'].present?
  end
  
  def not_found
    raise ActiveRecord::RecordNotFound, "Not Found"
  end  
end
