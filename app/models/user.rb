class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :orders
  has_many :unseens

  has_many :deleted_orders,
           class_name: Order,
           foreign_key: :deleted_by_id

  has_many :ready_to_delivery_orders,
           class_name: Order,
           foreign_key: :ready_to_delivery_by


  def generate_code
    update(code: rand(90_000) + 10_000)
  end

end
