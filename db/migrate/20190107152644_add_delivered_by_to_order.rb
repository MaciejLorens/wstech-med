class AddDeliveredByToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :delivered_by, :integer
  end
end
