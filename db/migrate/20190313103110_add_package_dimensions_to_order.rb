class AddPackageDimensionsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :package_dimensions, :string
  end
end
