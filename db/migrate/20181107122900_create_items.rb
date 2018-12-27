class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string   :description, null: false
      t.integer  :quantity,    null: false
      t.string   :color,       null: false
      t.integer  :order_id,    null: false
      t.boolean  :hidden,      null: false, default: false
      t.datetime :hidden_at,   null: true

      t.timestamps
    end

    add_index :items, :order_id
  end
end
