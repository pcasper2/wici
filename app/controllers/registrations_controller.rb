class RegistrationsController < Devise::RegistrationsController
  before_filter :config_permitted_parameters, only: [:create, :update]

  protected

  def config_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name, :email, :password, :current_password
  end

end