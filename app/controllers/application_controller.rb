class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_user_params, if: :devise_controller?

  protected

  def configure_permitted_user_params
    devise_parameter_sanitizer.
      for(:account_update).
      push(:first_name, :last_name, :about_me)
  end
end
