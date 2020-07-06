class AdminController < ApplicationController
  before_action :set_account, only: [:profile]

  def index
    @total_orders = Order.count
    @orders = Order.order(:created_at)
  end

end
