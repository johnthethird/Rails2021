Avo.configure do |config|
  config.root_path = '/avo'
  config.license = 'community'
  config.license_key = nil
end

# TODO figure this out

module ActionView
  class Base
    def current_user
      @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end
  end
end

module ActionController
  class Base
    def current_user
      @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end
  end
end