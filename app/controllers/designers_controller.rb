class DesignersController < ApplicationController

	def new
		
    end

    def create
    	salt = BCrypt::Engine.generate_salt
		encrypted_password = BCrypt::Engine.hash_secret(params["designer"]["password"], salt)
    	designer = Designer.new(name: params["designer"]["name"],phone: params["designer"]["phone"],
    		email: params["designer"]["email"], password: encrypted_password, salt:salt)
    	#raise
    	if designer.save
    		session[:designer_id] = designer.id 
    		redirect_to '/'
    	else
    		redirect_to '/signup'
    	end
    end


	# private
	# def designer_params
	# 		params.require(:designer).permit(:name, :phone, :email, :password, :password_confirmation)
	# end
end


