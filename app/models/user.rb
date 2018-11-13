class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :orders

  has_many :deleted_orders,
           class_name: Order,
           foreign_key: :deleted_by_id


  def orders_price_sum(from, to)
    order_ids = self.orders.delivered.from_to(from, to).map(&:id)
    items = Item.where(order_id: order_ids)
    items.map(&:price).sum
  end

  def orders_count_sum(from, to)
    orders = self.orders.delivered.from_to(from, to)
    orders.count
  end
end
