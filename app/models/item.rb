class Item < ActiveRecord::Base

  belongs_to :order

  validates_presence_of :description, :quantity, :price

end
