class DesignersController < ApplicationController

	def new
		
    end

    def create
    	missing_fields = Utils.check_missing_fields(params, ["name","email", "password", "password_confirmation", "phone"], "designer")
    	return redirect_to '/signup' , :flash => { :error => "Missing required fields" } if ( missing_fields.size > 0 )
    	return redirect_to '/signup' , :flash => { :error => "Password and password confirmation don't match" } if params["designer"]["password_confirmation"] !=  params["designer"]["password"]
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


