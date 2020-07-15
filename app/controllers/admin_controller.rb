class AdminController < ApplicationController
  before_action :set_account, only: [:profile]

  def landingpage
  end

  def index
    @total_orders = Order.count
    @orders = Order.order(:created_at)
  end

  def order
    @total_orders = Order.count
    @orders = Order.where(complete: 'f', Storeid: current_user.id).order(:created_at)

    @products = Product.order(:title)
    @line_items = LineItem.find_by_id(params[:id]
    )
    @cart = Cart.find_by_id(params[:id])

    def complete
      @order.update(complete: 'true')
    end

  end

  def edit
    @total_orders = Order.count
  end

  def products
    @total_orders = Order.count
    @products = Product.order(:title)
    @categories = Category.order(:category)
  end
end
