class Auth0Controller < ApplicationController
  def callback
    # The next few lines are an example of doing everything here in the controller.
    # user_params = user_params_from_omniauth(request.env['omniauth.auth'])
    # user = User.find_or_create_by(email: user_params[:email])
    # user.update!(user_params)

    # However, it is usually better to use "Service Objects" or "Interactors" to implement your business logic.
    # So instead we will use a seperate Interactor object to create a new user, so all the things that go along with that
    # (sending welcome emails, etc) can be extracted out of this controller.
    user_params = user_params_from_omniauth(request.env['omniauth.auth'])

    result = RegisterUser.new(user_params).call
    if result.success?
      # This stores the user id in a HTTP web session cookie
      session[:current_user_id] = result.user.id

      # Redirect to the URL you want after successful auth
      redirect_to root_url, notice: "Logged in!"
    else
      redirect_to root_url, alert: result.errors.full_messages.join(', ')
    end
  end

  def failure
    @error_msg = request.params['message']
    redirect_to root_url, alert: @error_msg
  end

  def logout
    session.delete(:current_user_id)
    redirect_to root_url, notice: "Logged out!"
  end

  def dev_login
    if Rails.env.development? 
      user = if params[:user_id].blank?
        User.all.order(:id).first
      else 
        User.find(params[:user_id])
      end
      session[:current_user_id] = user.id
      redirect_to root_url, notice: "Logged in as #{user.email} [id:#{user.id}]"
    else 
      redirect_to root_url, alert: 'dev_login only available in development mode!'
    end
  end

  private
  # Given a hash (which is found like this: request.env['omniauth.auth']) 
  # from the Auth0/Omniauth login callback, pick out what we need for a user record
  def user_params_from_omniauth(omni)
    {
      email: omni['info']['email'].downcase,
      firstname: omni['info']['name'].split(" ").first,
      lastname: omni['info']['name'].split(" ")[1..-1].join(" "),
      avatar_url: omni['info']['image']
    }
  end

end