class AddAmountToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :Amount, :decimal, precision: 8, scale: 2
  end
end
