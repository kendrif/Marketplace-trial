class ApplicationController < ActionController::Base
  #before_action :authorize
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to new_user_session_path, notice: "Please loggo"
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :s_name, :admin])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :s_name, :admin])
    end
    
end