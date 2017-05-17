class Designer < ApplicationRecord
	
	def self.confirm_email_designer(params)
		designer = self.find_by(confirmation_token: params["confirmation_token"])
		if designer
			self.where(unconfirmed_email: designer.unconfirmed_email).update_all(unconfirmed_email: "")
			designer.update(email: designer.unconfirmed_email, unconfirmed_email: "", confirmation_token: "", confirmed_at: Time.now) 
		end
	end
    
end
