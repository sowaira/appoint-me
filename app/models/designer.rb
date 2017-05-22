class Designer < ApplicationRecord
	
	def self.confirm_email_designer(params)
		designer = self.find_by(confirmation_token: params["confirmation_token"])
		if designer
			self.where(unconfirmed_email: designer.unconfirmed_email).update_all(unconfirmed_email: "")
			designer.update(email: designer.unconfirmed_email, unconfirmed_email: "", confirmation_token: "", confirmed_at: Time.now) 
		end
		designer
	end

	def self.invite_designer(params)
    	missing_fields = Utils.check_missing_fields(params, ["email"], "designer")

    	designer = Designer.new(	
    		unconfirmed_email: params["designer"]["email"],
    		confirmation_token: Digest::SHA1.hexdigest([Time.now, rand].join))
    	return if missing_fields.size > 0 or Designer.find_by(email: params["designer"]["email"])

    	if designer.save
    		MailerMailer.confirmation_email_designer(designer).deliver
    	end

    	designer
	end
    

    def self.reset_password(params, current_user)
    	
    end
end
