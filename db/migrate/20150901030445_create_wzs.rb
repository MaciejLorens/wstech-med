class CreateWzs < ActiveRecord::Migration
  def change
    create_table :wzs do |t|
      t.string   :number, null: false, default: ''

      t.timestamps null: false
    end
  end
end
