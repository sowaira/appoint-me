class Designer < ApplicationRecord
    belongs_to :business
    has_many :appointments

	mount_uploader :picture, GeneralPictureUploader



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

        return if missing_fields.size > 0 or Designer.find_by(email: params["designer"]["email"])
        designer = Designer.find_by(email: params["designer"]["email"]) || Designer.find_by(unconfirmed_email: params["designer"]["email"])
        
        unless designer
            designer = Designer.new(    
                unconfirmed_email: params["designer"]["email"],
                business_id: params["designer"]["business_id"],
                confirmation_token: Digest::SHA1.hexdigest([Time.now, rand].join))
        end

    	if designer.save
    		MailerMailer.confirmation_email_designer(designer).deliver
    	end

    	designer
	end

    def forename
        (self.name.present? ? self.name : self.email)
    end


    def foreemail
        (self.email.present? ? self.email : self.unconfirmed_email)
    end



end
