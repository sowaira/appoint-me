class Business < ApplicationRecord

    has_many :designers

	mount_uploader :picture, GeneralPictureUploader

	def self.create_business(params)
    	missing_fields = Utils.check_missing_fields(params,["name","address","latitude","longitude","email"], "business")

    	business = Business.new( 
    		name:params["business"]["name"],
    		unconfirmed_email: params["business"]["email"],
    		address:params["business"]["address"],
    		latitude:params["business"]["latitude"],
    		longitude:params["business"]["longitude"],
    		confirmation_token: Digest::SHA1.hexdigest([Time.now, rand].join))

    	return if missing_fields.size > 0 or Business.find_by(email: params["business"]["email"])
    	business.picture =  params["business"]["picture"]

    	if business.save
    		MailerMailer.confirmation_email_business(business).deliver
    	end
    	business
	end

    def update_business(params)
        missing_fields = Utils.check_missing_fields(params,["name","address","latitude","longitude"], "business")
        
        return if missing_fields.size > 0

        self.update( 
            name:params["business"]["name"],
            address:params["business"]["address"],
            latitude:params["business"]["latitude"],
            longitude:params["business"]["longitude"])

        if params["business"]["picture"].present?
            self.picture =  params["business"]["picture"] 
            self.save
        end
    end


	def self.confirm_email_business(params)
		business = self.find_by(confirmation_token: params["confirmation_token"])
		if business
			self.where(unconfirmed_email: business.unconfirmed_email).update_all(unconfirmed_email: "")
			business.update(email: business.unconfirmed_email, unconfirmed_email: "", confirmation_token: "", confirmed_at: Time.now) 
		end
		business
	end


end
