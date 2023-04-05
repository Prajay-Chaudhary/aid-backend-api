class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:signup, keys: %i[first_name last_name username email])
  #   #devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  # end

  def configure_permitted_parameters
    attributes = [:first_name, :last_name, :username, :email]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
   # devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end