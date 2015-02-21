class CreateOrders < ActiveRecord::Migration
  def change
    create_table(:orders) do |t|
      t.text      :description,       null: false, default: ''
      t.integer   :user_id,           null: false
      t.integer   :quantity,          null: false
      t.decimal   :price,             null: false, precision: 8, scale: 2
      t.string    :wz_name
      t.datetime  :delivery_request_date, null: false
      t.datetime  :confirmation_date
      t.datetime  :invoice_date
      t.datetime  :delivery_date
      t.string    :status,            null: false, default: 'not_confirmed'
      t.string    :type,              null: false

      t.timestamps
    end

    add_index :orders, :user_id
  end
end
