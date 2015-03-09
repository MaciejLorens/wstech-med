class Wz < ActiveRecord::Base
  has_many :orders
  has_many :metal_orders, -> () { where type: 'MetalOrder' }, class_name: 'Order'
  has_many :furniture_orders, -> () { where type: 'FurnitureOrder' }, class_name: 'Order'

  validates_presence_of :number

  scope :at_date, ->(date) {Wz.where('created_at >= ? AND created_at < ?', date.beginning_of_day, date.beginning_of_day + 1.day)}

  after_create :set_number

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << Order.column_names
      orders.each do |order|
        csv << order.attributes.values_at(*Order.column_names)
      end
    end
  end

  private

  def set_number
    time = Time.now
    self.update_column(:number, "WZ/#{time.strftime('%y')}/#{time.month}/#{time.day}/#{self.id}")
  end
end
