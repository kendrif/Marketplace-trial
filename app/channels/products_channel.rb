class ProductsChannel < ApplicationCable::Channel
  def subscribed
    steam_from "products"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
