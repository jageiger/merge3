class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected
  

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
  end
  
  def production?
    Rails.env == 'production'
  end

  def development?
    Rails.env == 'development'
  end

  def authenticate
    if conf = JsonConfig.get
      if conf["password"]
        authenticate_or_request_with_http_basic do |username, password|
          username == conf["username"] && password == conf["password"]
        end
      end
    end
  end
  
  
  
  
  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end
  
  

end
