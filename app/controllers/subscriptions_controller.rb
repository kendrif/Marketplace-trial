class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @account = User.find_by_id(params[:id])
  end

  # Reference:
  # https://stripe.com/docs/connect/subscriptions
  def create
    @account = User.find_by_id(params[:id])
    key = @account.user.access_code
    Stripe.api_key = key

    plan_id = params[:plan]
    plan = Stripe::Plan.retrieve(plan_id)
    token = params[:stripeToken]


    customer = if current_user.stripe_id?
                Stripe::Customer.retrieve(current_user.stripe_id)
              else
                Stripe::Customer.create(email: current_user.email, source: token)
              end

              Stripe::PaymentIntent.create({
                customer: customer,
                amount: @cart.total_price * 100,
                confirm: true,
                currency: 'gbp',
                payment_method_types: ['card'],
                application_fee_percent: 3,
              }, {
                stripe_account: 'key',
              })


    options = {
      stripe_id: customer.id,
      subscribed: true,
    }

    options.merge!(
      card_last4: params[:user][:card_last4],
      card_exp_month: params[:user][:card_exp_month],
      card_exp_year: params[:user][:card_exp_year],
      card_type: params[:user][:card_brand]
    )

    current_user.perk_subscriptions << plan_id
    current_user.update(options)

    # Update project attributes
    project_updates = {
      backings_count: @project.backings_count.next,
      current_donation_amount: @project.current_donation_amount + (plan.amount/100).to_i,
    }
    @project.update(project_updates)


    redirect_to root_path, notice: "Your subscription was setup successfully!"
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
