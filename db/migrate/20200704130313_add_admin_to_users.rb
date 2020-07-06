class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :s_name, :string 
  end
end
