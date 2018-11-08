class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string   :description, null: false
      t.integer  :quantity,    null: false
      t.decimal  :price,       null: false, precision: 8, scale: 2
      t.integer  :order_id,    null: false

      t.timestamps
    end

    add_index :items, :order_id
  end
end
