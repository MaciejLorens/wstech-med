class CreateOrders < ActiveRecord::Migration
  def change
    create_table(:orders) do |t|
      t.string    :number
      t.integer   :user_id,               null: false
      t.integer   :purchaser_id,          null: false
      t.datetime  :delivery_request_date, null: false
      t.datetime  :ready_to_delivery_at
      t.datetime  :delivered_at
      t.datetime  :deleted_at,            null: true
      t.integer   :deleted_by_id,         null: true
      t.string    :invoice_number,        null: true
      t.string    :serial_number,         null: true
      t.string    :shipping_address,      null: true
      t.string    :status,                null: false, default: 'ordered'

      t.timestamps
    end

    add_index :orders, :number
    add_index :orders, :user_id
    add_index :orders, :purchaser_id
    add_index :orders, :invoice_number
    add_index :orders, :serial_number
    add_index :orders, :status

  end
end
