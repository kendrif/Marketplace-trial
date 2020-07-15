class AddNumberToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :Number, :string
  end
end
