class DesignersController < ApplicationController

	def new
		
    end

    def create
    	missing_fields = Utils.check_missing_fields(params, ["name","email", "password", "password_confirmation", "phone"], "designer")
    	return redirect_to signup_designer_path, alert: "Missing required fields"  if ( missing_fields.size > 0 )
    	return redirect_to signup_designer_path, alert: "Password and password confirmation don't match"  if params["designer"]["password_confirmation"] !=  params["designer"]["password"]
    	salt = BCrypt::Engine.generate_salt
		encrypted_password = BCrypt::Engine.hash_secret(params["designer"]["password"], salt)
    	designer = Designer.new(name: params["designer"]["name"],phone: params["designer"]["phone"],
    		unconfirmed_email: params["designer"]["email"], password: encrypted_password, salt:salt,
    		confirmation_token: Digest::SHA1.hexdigest([Time.now, rand].join))
    	if designer.save
    		MailerMailer.confirmation_email_designer(designer).deliver
    		session[:designer_id] = designer.id 
    		redirect_to '/'
    	else
    		redirect_to '/signup'
    	end
    end

	

end


