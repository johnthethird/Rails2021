class RegisterUser < ApplicationInteractor

  attr_reader :user_params

  # RegisterUser will create a new user in the database and send any relevant emails out
  # 
  # @param [Hash] user_params
  # @option user_params [String] :email 
  # @option user_params [String] :firstname
  # @option user_params [String] :lastname
  # @option user_params [String] :avatar_url
  # @return user [User] a newly created User which has been persisted to the DB
  def initialize(user_params)
    @user_params = user_params
  end

  private
  # You put your biz logic in this inner_call method
  def inner_call
    # Try to find the user in the DB first
    if user = User.where(email: user_params[:email]).first
      # They exist, but lets update their name and avatar with the new ones we got from Auth0
      user.update!(user_params)
    
    # User doesnt exist, so we need to create them, and do whatever else we need to do when registering a new user
    else
      user = User.create!(user_params)
      make_first_user_admin(user)
      # We used the bang method above (create!) so that any validation error will throw an exception and we will not
      # continue on to this next line where we send the welcome email.
      NotifyMailer.with(user: user).welcome_email.deliver_later
    end
    
    success(user: user)
  end

  def make_first_user_admin(user)
    if User.count == 0
      user.status = 'admin'
      user.save!
    end
  end

end