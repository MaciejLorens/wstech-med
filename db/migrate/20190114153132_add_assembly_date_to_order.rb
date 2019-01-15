class AddAssemblyDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :assembly_at, :datetime
  end
end
