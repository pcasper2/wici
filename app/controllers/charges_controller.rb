class ChargesController < ApplicationController
  def create
  @amount = 15_00
 
  # Where the real magic happens
  if current_user.customer_id.nil?
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    ) 
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )
    current_user.customer_id = customer.id
    flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
  else
    flash[:error] = "You have already paid for the BigMoney Membership, but thanks for the thought!"
  end
  current_user.update_attribute(:role, "premium")

  redirect_to root_path # or wherever
 
  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end


  def new
    @amount = 15_00
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: @amount
    }
  end

  def downgrade
    current_user.make_wicis_public
    customer = Stripe::Customer.retrieve(current_user.customer_id)
    customer.delete
    current_user.update_attributes(role: 'standard')
    current_user.update_attributes(customer_id: nil)
    redirect_to edit_user_registration_path
  end
end


