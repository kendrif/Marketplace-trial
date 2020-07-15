class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true

  def total_price 
    product.price.to_i * quantity.to_i
  end 
  
end
