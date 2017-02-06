class AddStatusToWzs < ActiveRecord::Migration
  def change
    add_column :wzs, :status, :string
  end
end
