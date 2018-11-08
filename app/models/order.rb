class Order < ActiveRecord::Base

  has_many :resources
  has_many :items

  belongs_to :purchaser
  belongs_to :user

  accepts_nested_attributes_for :resources, :items

  has_paper_trail

  validates_presence_of :purchaser_id, :user_id, :delivery_request_date, :status

  after_create :set_number

  scope :at_date, ->(date) { where('created_at >= ? AND created_at < ?', date.beginning_of_day, date.beginning_of_day + 1.day) }
  scope :delivered_at, ->(date) { where('delivery_date >= ? AND delivery_date < ?', date.beginning_of_day, date.beginning_of_day + 1.day) }
  scope :at_status, ->(status) { where('status = ?', status) }
  scope :at_year_at_month, ->(year, month) { where('orders.created_at >= ? AND orders.created_at < ?', "#{year}/#{month}/01".to_datetime, "#{year}/#{month}/01".to_datetime.end_of_month) }

  def self.to_csv(status)
    @orders = self.where(status: status).order(created_at: :asc)
    CSV.generate do |csv|
      csv << ['Id', 'Opis', 'Twórca', 'Zamawiający', 'Data zlecenia', 'Na kiedy ma być', 'Ilość', 'Cena', 'Fakturowano dnia', 'Data realizacji']
      @orders.each do |order|
        csv << [order.number, order.description, "#{order.user.first_name} #{order.user.last_name}", order.purchaser, date(order.created_at), date(order.delivery_request_date), order.quantity, order.price, date(order.delivery_date)]
      end
    end
  end

  private

  def set_number
    time = Time.now
    self.update_column(:number, "ZM/#{time.strftime('%y')}/#{time.month}/#{time.day}/#{self.id}")
  end

  def self.date(date)
    date.localtime.strftime('%d-%m-%Y') if date.present?
  end

end
