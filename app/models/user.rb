class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :metal_orders, -> () { where type: 'MetalOrder' }, class_name: 'Order'
  has_many :furniture_orders, -> () { where type: 'FurnitureOrder' }, class_name: 'Order'
end
