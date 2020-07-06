class StoreController < ApplicationController
  before_action :set_account, only: [:show]

  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
  end

  def profile
    @products = Product.order(:title)
    @account = User.find_by_id(params[:id])
  end

end
