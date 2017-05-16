class Authentication < ApplicationRecord
	belongs_to :client
	class << self
	  def create_auth(params, client)
	    self.create(
	      os: (params["auth"]["os"] rescue "web"),
	      language: (params["auth"]["language"] rescue "en"),
	      reg_id: (params["auth"]["reg_id"] rescue nil),
	      device_id: (params["auth"]["device_id"] rescue nil),
	      access_token: Digest::SHA1.hexdigest([Time.now, rand].join),
	      client_id: client.id
	    )
	  end
	end
end
