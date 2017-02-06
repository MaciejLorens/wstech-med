class AddDeletedDeletedAtDeletedByToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :deleted_at, :datetime
    add_column :orders, :deleted_by, :string
  end
end
