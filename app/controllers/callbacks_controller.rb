class CallbacksController < ApplicationController

	def email_confirmation
		Client.confirm_email(params)
		redirect_to root_url
	end

	def email_confirmation_designer
		designer = Designer.confirm_email_designer(params)
		if designer and not designer.password.present?
			session[:current_email] = designer.email 
			redirect_to define_password_designer_path
		else
			redirect_to root_url
		end
	end

end
