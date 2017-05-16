class CallbacksController < ApplicationController

	def email_confirmation
		Client.confirm_email(params)
		redirect_to "/"
	end
end
