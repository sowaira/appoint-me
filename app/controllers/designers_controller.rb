class DesignersController < ApplicationController


    def login
    end

    def create_session
        unconfirmed_designer = Designer.find_by(unconfirmed_email: params["designer"]["email"])
        return redirect_to login_designer_path, alert: "Designer account not confirmed yet!" if unconfirmed_designer
        designer = Designer.find_by_email(params["designer"]["email"])
        if designer && Utils.match_password(designer.password, params["designer"]["password"], designer.salt)
          session[:designer_id] = designer.id
          redirect_to root_url
        else
          redirect_to login_designer_path, alert: "Email or password is incorrect"
        end
    end

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
    		redirect_to root_url
    	else
    		redirect_to signup_designer_path
    	end
    end

    def define_password
    end

    def reset_password
        designer = Designer.find_by(email: session[:current_email])
        missing_fields = Utils.check_missing_fields(params, ["password", "password_confirmation"], "designer")
        return redirect_to define_password_designer_path, alert: "Missing required fields"  if ( missing_fields.size > 0 )
        return redirect_to define_password_designer_path, alert: "Password and password confirmation don't match"  if params["designer"]["password_confirmation"] !=  params["designer"]["password"]
        salt = BCrypt::Engine.generate_salt
        encrypted_password = BCrypt::Engine.hash_secret(params["designer"]["password"], salt)
        designer.update( password: encrypted_password, salt:salt, confirmation_token: Digest::SHA1.hexdigest([Time.now, rand].join))

        redirect_to login_designer_path, notice: "Password defined successfully"
    end

    def destroy
        session[:designer_id] = nil
        session[:current_email] = nil
        redirect_to login_designer_path
    end

end


