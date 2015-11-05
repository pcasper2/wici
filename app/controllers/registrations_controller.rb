class RegistrationsController < Devise::RegistrationsController
  before_filter :config_permitted_parameters, only: [:create, :update]

  def edit
    @amount = 15_00
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: @amount
    }
  end

  protected

  def config_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name, :email, :password, :current_password
  end

end