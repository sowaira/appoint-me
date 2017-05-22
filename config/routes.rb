Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

	root :to =>  "globals#home"

	# globlas
		get '/' => 'globals#home', as: :home
	
	# designers
		get '/designers/login' => 'designers#login', as: :login_designer
		post '/designers/session' => 'designers#create_session', as: :create_session_designer
		get '/designers/logout' => 'designers#destroy', as: :logout_designer
		get '/designers/define_password' => 'designers#define_password', as: :define_password_designer
		post '/designers/reset_password' => 'designers#reset_password', as: :reset_password_designer
		get '/designers/settings' => 'designers#settings', as: :settings_designer
		put '/designers/' => 'designers#update_settings', as: :update_settings_designer


		
		get '/designers/signup' => 'designers#new',  as: :signup_designer
		post '/designers' => 'designers#create' , as: :create_designer

		get '/clients/email_confirmation' => "callbacks#email_confirmation", as: :email_confirmation
		get '/designers/email_confirmation' => "callbacks#email_confirmation_designer", as: :email_confirmation_designer

  #api
	namespace :api , :defaults => { :format => 'json' } do
    
    	post '/clients/sign_up', to: 'clients#sign_up'
    	post '/clients/sign_in', to: 'clients#sign_in'
    	delete '/clients/logout', to: 'clients#logout'

    end



end
