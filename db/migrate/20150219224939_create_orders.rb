class CreateOrders < ActiveRecord::Migration
  def change
    create_table(:orders) do |t|
      t.string    :number
      t.text      :description,       null: false
      t.integer   :user_id,           null: false
      t.integer   :wz_id,             null: true
      t.integer   :quantity,          null: false
      t.decimal   :price,             null: true, precision: 8, scale: 2
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
