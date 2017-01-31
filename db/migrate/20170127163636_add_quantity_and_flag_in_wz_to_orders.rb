class AddQuantityAndFlagInWzToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :quantity_in_wz, :integer, default: 0
    add_column :orders, :full_in_wz, :boolean, default: false
    Order.update_all(quantity_in_wz: 0)
  end
end
