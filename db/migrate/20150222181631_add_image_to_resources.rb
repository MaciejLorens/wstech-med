class AddImageToResources < ActiveRecord::Migration
  def self.up
    add_attachment :resources, :image
  end

  def self.down
    remove_attachment :resources, :image
  end
end
