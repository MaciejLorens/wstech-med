class AddReadyToDeliveryByAgainToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :ready_to_delivery_by, :integer
  end
end
