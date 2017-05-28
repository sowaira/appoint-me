class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	def current_business
		@current_business ||= Business.find_by_id(session[:business_id]) if session[:business_id]
	end
	helper_method :current_business

    def current_designer
      @current_designer ||= Designer.find_by_id(session[:designer_id]) if session[:designer_id]
    end
    helper_method :current_designer

    def authorize
      redirect_to login_designer_path unless current_designer
    end

    def authorize_business
      redirect_to login_business_path unless current_business
    end

end
