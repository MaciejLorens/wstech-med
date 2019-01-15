class AddAssemblyDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :assembly_date, :datetime
  end
end
