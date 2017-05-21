Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

	root :to =>  "globals#home"

	# globlas
		get '/' => 'globals#home', as: :home
	
	# designers
		get '/login' => 'sessions#new', as: :login_designer
		post '/login' => 'sessions#create', as: :login_desiger
		get '/logout' => 'sessions#destroy', as: :logout_designer
		
		get '/signup' => 'designers#new',  as: :signup_designer
		post '/designers' => 'designers#create' , as: :signup_desiger

		get '/email_confirmation' => "callbacks#email_confirmation", as: :email_confirmation
		get '/email_confirmation_designer' => "callbacks#email_confirmation_designer", as: :email_confirmation_designer

  #api
	namespace :api , :defaults => { :format => 'json' } do
    
    	post 'sign_up', to: 'clients#sign_up'
    	post 'sign_in', to: 'clients#sign_in'
    	delete 'logout', to: 'clients#logout'

    end



end
