class Client < ApplicationRecord
	has_many :authentications

	def self.sign_in(params)
			unconfirmed_client = self.find_by(unconfirmed_email: params["client"]["email"])
			return Utils.render_json({codeError: 13, message: "Client account not confirmed yet!"}, 403) if unconfirmed_client
			client = self.find_by(email: params["client"]["email"])
			if client and Utils.match_password(client.password, params["client"]["password"], client.salt)
				auth = Authentication.create_auth(params, client)
				return Utils.render_json({client: client, auth: auth}, 200)
		    end
		    return Utils.render_json({codeError: 4, message: "Email or Password incorrect"}, 403)
	end

	def self.sign_up(params)
		missing_fields = Utils.check_missing_fields(params, ["email", "password", "password_confirmation", "name"], "client")
		return Utils.render_json({codeError: 2, message: "Missing required fields", missing_fileds: missing_fields}, 400) if missing_fields.size > 0

		return Utils.render_json({codeError: 3, message: "password confirmation doesn't match"}, 400) if params["client"]["password"] != params["client"]["password_confirmation"]

		client = self.find_by(email: params["client"]["email"])
		if client
	    	return Utils.render_json({codeError: 1, message: "Email already exist"}, 403)
	    else
    		client = self.create_client(params)
	    	MailerMailer.confirmation_email(client).deliver
	    	return Utils.render_json({message: "client created successfully. please confirm your account!"}, 200)
	    end
	end


	def self.create_client(params)
    	salt = BCrypt::Engine.generate_salt
		encrypted_password = BCrypt::Engine.hash_secret(params["client"]["password"], salt)
		client = self.create(   name: params["client"]['name'],
								unconfirmed_email: params["client"]['email'],
								password: encrypted_password,
								salt: salt,
								picture: params["client"]["picture"],
								confirmation_token: Digest::SHA1.hexdigest([Time.now, rand].join), 
								token: Digest::SHA1.hexdigest([Time.now, rand].join))
		client
	end

	def logout
		self.authentications.destroy_all
		return result = Utils.render_json({message: "Client logged out"}, 200)
	end

	def self.confirm_email(params)
		client = self.find_by(confirmation_token: params["confirmation_token"])
		if client
			self.where(unconfirmed_email: client.unconfirmed_email).update_all(unconfirmed_email: "")
			client.update(email: client.unconfirmed_email, unconfirmed_email: "", confirmation_token: "", confirmed_at: Time.now) 
		end
	end
end
