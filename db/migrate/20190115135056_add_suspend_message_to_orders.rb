class AddSuspendMessageToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :suspend_message, :string
  end
end
