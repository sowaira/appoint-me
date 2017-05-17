class CallbacksController < ApplicationController

	def email_confirmation
		Client.confirm_email(params)
		redirect_to "/"
	end

	def email_confirmation_designer
		Designer.confirm_email_designer(params)
		redirect_to "/"
	end

end
