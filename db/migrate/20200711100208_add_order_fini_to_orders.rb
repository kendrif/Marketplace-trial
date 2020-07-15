class AddOrderFiniToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :OrderFini, :boolean, default: false
  end
end
