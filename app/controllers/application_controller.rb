class ApplicationController < ActionController::Base
  before_action :set_meta_tags

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def after_sign_in_path_for(resource_or_scope)
    # Define the path to redirect after sign in
    # dashboard_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :phone_number, :description, :image])
  end

  private

  def set_meta_tags
    # Correct usage: setting meta tags without recursive call
    @meta_tags = {}
  end
end