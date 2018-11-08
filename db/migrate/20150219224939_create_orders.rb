class CreateOrders < ActiveRecord::Migration
  def change
    create_table(:orders) do |t|
      t.string    :number
      t.integer   :user_id,               null: false
      t.integer   :purchaser_id,          null: false
      t.datetime  :delivery_request_date, null: false
      t.datetime  :delivery_date
      t.datetime  :completed_at
      t.datetime  :deleted_at,            null: true
      t.string    :deleted_by,            null: true
      t.string    :status,                null: false, default: 'ordered'

      t.timestamps
    end

    add_index :orders, :user_id
  end
end
