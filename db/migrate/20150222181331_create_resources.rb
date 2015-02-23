class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :order_id
      t.string :link

      t.timestamps null: false
    end
  end
end
