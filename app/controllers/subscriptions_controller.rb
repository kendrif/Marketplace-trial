class SubscriptionsController < ApplicationController

  def new
    @account = User.find_by_id(params[:account_id])
    @order = Order.find(params[:order])
  end

  # Reference:
  # https://stripe.com/docs/connect/subscriptions
  def create
    @account = User.find_by_id(params[:account_id])
    key = @account.access_code
    Stripe.api_key = key
    account_suid = @account.uid
    @order = Order.find(params[:order])
    charge = @order.amount * 100
    fee = @order.amount * 1
  

    token = params[:stripeToken]


    customer = Stripe::Customer.create(email: @order.email, source: token)

              
              Stripe::PaymentIntent.create({
                customer: customer,
                amount: (charge).to_i, 
                confirm: true,
                currency: 'gbp',
                payment_method_types: ['card'],
                application_fee_amount: (fee).to_i,
              }, {
                stripe_account: account_suid
              })


    options = {
      stripe_id: customer.id
    }

    options.merge!(
      card_last4: params[:user][:card_last4],
      card_exp_month: params[:user][:card_exp_month],
      card_exp_year: params[:user][:card_exp_year],
      card_type: params[:user][:card_brand]
    )
    
    redirect_to "http://www.rubyonrails.org"
    
  end

  def destroy
    subscription_to_remove = params[:id]
    plan_to_remove = params[:plan_id]
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(subscription_to_remove).delete
    current_user.subscribed = false
    current_user.perk_subscriptions.delete(plan_to_remove)
    current_user.save
    redirect_to root_path, notice: "Your subscription has been cancelled."
  end
end
