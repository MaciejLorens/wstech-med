class CreatePurchasers < ActiveRecord::Migration
  def change
    create_table :purchasers do |t|
      t.string   :name, null: false
    end

    add_index :purchasers, :name
  end
end
