class CreateOrdersWzs < ActiveRecord::Migration
  def change
    create_table :orders_wzs do |t|
      t.integer   :order_id, null: false
      t.integer   :wz_id, null: false
      t.integer   :quantity, default: 0
    end
  end
end
