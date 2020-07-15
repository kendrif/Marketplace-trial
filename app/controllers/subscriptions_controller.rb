class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @account = User.find_by_id(params[:account_id])
  end

  # Reference:
  # https://stripe.com/docs/connect/subscriptions
  def create
    @account = User.find_by_id(params[:account_id])
    key = @account.access_code
    Stripe.api_key = key
    account_suid = @account.uid
    token = params[:stripeToken]


    customer = if current_user.stripe_id?
                Stripe::Customer.retrieve(current_user.stripe_id)
              else
                Stripe::Customer.create(email: current_user.email, source: token)
              end

              
              Stripe::PaymentIntent.create({
                customer: customer,
                amount: 100, 
                confirm: true,
                currency: 'gbp',
                payment_method_types: ['card'],
                application_fee_amount: 3,
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
    
    order_fini_job.perform_now(@order)
    redirect_to root_path, notice: "Your subscription was boner successfully!"
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
