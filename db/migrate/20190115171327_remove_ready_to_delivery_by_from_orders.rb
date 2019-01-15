class RemoveReadyToDeliveryByFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :ready_to_delivery_by
  end
end
