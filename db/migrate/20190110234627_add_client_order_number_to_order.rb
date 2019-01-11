class AddClientOrderNumberToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :client_order_number, :string
  end
end
