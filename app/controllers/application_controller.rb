class ApplicationController < ActionController::Base
  Unauthorized = Class.new(StandardError)

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_user_params

  protected

  def configure_permitted_user_params
    devise_parameter_sanitizer.
      for(:account_update).
      push(:first_name, :last_name, :about_me)
  end

  def allowed_user_params
    devise_parameter_sanitizer.account_update
  end

  def resource_class; User; end
  def resource_name; resource_class.to_s.underscore; end
  helper_method :resource_class, :resource_name

  def authorize_access!(condition = false)
    raise Unauthorized unless condition
  end
end
