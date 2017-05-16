class Api::ClientsController < Api::ApplicationController

	before_action :authenticate, only: [:logout]

	def sign_up
        result = Client.sign_up(params)
        render result
    end

    def sign_in
        result = Client.sign_in(params)
        render result
    end

    def logout
    	result = @client.logout
        render result
    end


end