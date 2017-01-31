class OrdersWz < ActiveRecord::Base
  belongs_to :order
  belongs_to :wz

  validates_uniqueness_of :order_id, :scope => :wz_id
end
