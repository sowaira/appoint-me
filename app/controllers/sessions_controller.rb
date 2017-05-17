class SessionsController < ApplicationController

	def new

	end

	def create
		designer = Designer.find_by_email(params["designer"]["email"])
	    if designer && Utils.match_password(designer.password, params["designer"]["password"], designer.salt)
	      session[:designer_id] = designer.id
	      redirect_to '/'
	    else
	      redirect_to '/login'
	    end
	end

	def destroy
		session[:designer_id] = nil
		redirect_to '/login'
	end

end
