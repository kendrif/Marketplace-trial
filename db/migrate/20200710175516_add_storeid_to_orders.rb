class AddStoreidToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :Storeid, :integer
  end
end
