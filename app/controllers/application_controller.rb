class ApplicationController < ActionController::Base
  Unauthorized = Class.new(StandardError)

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_user_params
  before_action :set_container_classes

  layout lambda { |controller| !controller.request.xhr? && 'application' }

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

  def default_context
    {current_user: current_user}
  end

  def set_container_classes
    @container_classes = response.headers['X-Container-Classes'] = "#{controller_name}-#{action_name}"
  end

  def set_flash
    if perspectives_enabled_action?
      response.headers['X-Flash-Perspective'] = perspective('flash_messages', flash: flash).to_json
    end
  end
end
