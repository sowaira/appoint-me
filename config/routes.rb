Rails.application.routes.draw do
	ActiveAdmin.routes(self)
	
	# designers
		get '/login' => 'sessions#new'
		post '/login' => 'sessions#create', as: :login_desiger
		get '/logout' => 'sessions#destroy'
		
		get '/signup' => 'designers#new',  as: :signup_designer
		post '/designers' => 'designers#create' , as: :signup_desiger
	# get '/designers/login' => "designers#login", as: :login

		get '/email_confirmation' => "callbacks#email_confirmation", as: :email_confirmation

  #api
	namespace :api , :defaults => { :format => 'json' } do
    
    	post 'sign_up', to: 'clients#sign_up'
    	post 'sign_in', to: 'clients#sign_in'
    	delete 'logout', to: 'clients#logout'

    end



end
