class BusinessesController < ApplicationController

	def show
		
	end

	def login
	end

	def create_session
	    unconfirmed_business = Business.find_by(unconfirmed_email: params["business"]["email"])
	    return redirect_to login_business_path, alert: "Business account not confirmed yet!" if unconfirmed_business
	    business = Business.find_by_email(params["business"]["email"])
	    if business && Utils.match_password(business.encripted_password, params["business"]["password"], business.salt)
	      session[:business_id] = business.id
	      redirect_to root_url
	    else
	      redirect_to login_business_path, alert: "Email or password is incorrect"
	    end
	end

	def define_password
	end

	def reset_password
	    business = Business.find_by(email: session[:current_email])
	    missing_fields = Utils.check_missing_fields(params, ["password", "password_confirmation"], "business")
	    return redirect_to define_password_business_path, alert: "Missing required fields"  if ( missing_fields.size > 0 )
	    return redirect_to define_password_business_path, alert: "Password and password confirmation don't match"  if params["business"]["password_confirmation"] !=  params["business"]["password"]
	    salt = BCrypt::Engine.generate_salt
	    encripted_password = BCrypt::Engine.hash_secret(params["business"]["password"], salt)
	    business.update( encripted_password: encripted_password, salt:salt, confirmation_token: Digest::SHA1.hexdigest([Time.now, rand].join))

	    redirect_to login_business_path, notice: "Password defined successfully"
	end

	def destroy
        session[:business_id] = nil
        session[:current_email] = nil
        redirect_to login_business_path
    end
end
