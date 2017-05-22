class Utils
	class << self
		def render_json(object, status)
			{
				json:  object,
				status:  status,
				root: false
		    }
		end

		def check_missing_fields(params, fields, parent_prm_name)
			missing_fields = []
			fields.each do |field|
				missing_fields << field unless params[parent_prm_name][field].present?
			end
			missing_fields
		end

		def match_password(encrypted_password, password="", salt)
		  	encrypted_password == BCrypt::Engine.hash_secret(password, salt)
		rescue
			false
		end
	end
end