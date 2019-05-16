class AddStagesToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :stages, :string, array: true, default: []
  end
end
