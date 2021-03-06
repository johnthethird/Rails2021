Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root 'home#show'

    admin_constraint = lambda { |request| request.session[:current_user_id] }

    constraints(admin_constraint) do
      mount GoodJob::Engine => 'good_job'
      mount Avo::Engine => Avo.configuration.root_path
    end

    get 'auth/auth0/callback' => 'auth0#callback'
    get 'auth/failure' => 'auth0#failure'
    get 'auth/logout' => 'auth0#logout'
    get 'auth/login_as' => 'auth0#login_as'

    get 'home', to: 'home#show'
    get 'about', to: 'home#about'
    get 'cards/search' => 'cards#search'
    resources :cards
  end
