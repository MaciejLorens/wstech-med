class Order < ActiveRecord::Base

  has_many :items

  belongs_to :purchaser
  belongs_to :user

  belongs_to :deleted_by,
             class_name: User,
             foreign_key: :deleted_by_id

  accepts_nested_attributes_for :items

  has_paper_trail

  validates_presence_of :purchaser_id, :user_id, :delivery_request_date, :status

  before_create :set_number

  scope :at_date, ->(date) { where('created_at >= ? AND created_at < ?', date.beginning_of_day, date.beginning_of_day + 1.day) }
  scope :from_to, ->(from, to) { where('created_at >= ? AND created_at < ?', from, to) }
  scope :delivered, ->() { where('status = ?', 'delivered') }
  scope :at_status, ->(status) { where('status = ?', status) }
  scope :at_year_at_month, ->(year, month) { where('orders.created_at >= ? AND orders.created_at < ?', "#{year}/#{month}/01".to_datetime, "#{year}/#{month}/01".to_datetime.end_of_month) }

  def self.to_csv(status)
    @orders = self.where(status: status).order(created_at:   :asc)
    CSV.generate do |csv|
      csv << ['Id', 'Opis', 'Twórca', 'Zamawiający', 'Data zlecenia', 'Na kiedy ma być', 'Ilość', 'Cena']
      @orders.each do |order|
        csv << [order.number, order.description, "#{order.user.first_name} #{order.user.last_name}", order.purchaser, date(order.created_at), date(order.delivery_request_date), order.quantity, order.price]
      end
    end
  end

  def self.price_sum(from, to)
    order_ids = Order.delivered.from_to(from, to).map(&:id)
    items = Item.where(order_id: order_ids)
    items.map(&:price).sum
  end

  def self.count_sum(from, to)
    orders = Order.delivered.from_to(from, to)
    orders.count
  end

  private

  def self.date(date)
    date.localtime.strftime('%d-%m-%Y') if date.present?
  end

  def set_number
    time = Time.now
    this_month_orders_count = Order.where('created_at >= ?', DateTime.now.beginning_of_month).count
    self.number = "ZM/#{time.strftime('%y')}/#{time.month}/#{this_month_orders_count + 1}"
  end

end
