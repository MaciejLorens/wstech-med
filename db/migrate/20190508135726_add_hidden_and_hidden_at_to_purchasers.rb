class AddHiddenAndHiddenAtToPurchasers < ActiveRecord::Migration
  def change
    add_column :purchasers, :hidden, :boolean,      null: false, default: false
    add_column :purchasers, :hidden_at, :datetime,  null: true
    add_index :purchasers, :hidden
  end
end
