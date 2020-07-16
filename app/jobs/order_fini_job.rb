class OrderFiniJob < ApplicationJob
  queue_as :default

  def perform(order)
    @order = order

    @order.OrderFini = 't'

    @order.save!

  end
end
