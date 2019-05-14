class RemoveAssemblyAtFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :assembly_at
  end
end
