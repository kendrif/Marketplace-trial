class AdminController < ApplicationController
  before_action :set_account, only: [:profile]

  def landingpage
    render layout: false
  end

  def index
    @total_orders = Order.count
    @orders = Order.order(:created_at)
  end

  def order
    @total_orders = Order.count
    @orders = Order.where(complete: 'f', OrderFini: 't', Storeid: current_user.id).order(:created_at)
    @products = Product.order(:title)
    @line_items = LineItem.find_by_id(params[:id])
    @cart = Cart.find_by_id(params[:id])

    def complete
      @order.update(complete: 'true')
    end

  end

  def orderarchive
    @total_orders = Order.count
    @orders = Order.where(complete: 't', OrderFini: 't', Storeid: current_user.id).order(:created_at)
    @products = Product.order(:title)
    @line_items = LineItem.find_by_id(params[:id])
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
    @products = Product.where(user_id: current_user.id).order(:title)

    @categories = Category.order(:category)
  end
end
