class CreateUnseens < ActiveRecord::Migration
  def change
    create_table :unseens do |t|
      t.integer :user_id
      t.integer :order_id

      t.timestamps null: false
    end

    add_index :unseens, :user_id
    add_index :unseens, :order_id

  end
end
