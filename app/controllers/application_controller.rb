class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

    def current_designer
      @current_designer ||= Designer.find(session[:designer_id]) if session[:designer_id]
    end
    helper_method :current_designer

    def authorize
      redirect_to login_designer_path unless current_designer
    end

end
