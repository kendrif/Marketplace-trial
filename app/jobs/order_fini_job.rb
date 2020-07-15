class OrderFiniJob < ApplicationJob
  queue_as :default

  def perform(order)
    @order = order 

    @order.toggle!(:OrderFiniJob)
    @order.save!
  end
end
