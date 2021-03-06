class Order < ActiveRecord::Base

  has_many :items
  has_many :unseens

  belongs_to :purchaser
  belongs_to :user

  belongs_to :deleted_by,
             class_name: User,
             foreign_key: :deleted_by_id

  belongs_to :assembler,
             class_name: User,
             foreign_key: :ready_to_delivery_by

  accepts_nested_attributes_for :items

  has_paper_trail

  validates_presence_of :user_id, :delivery_request_date, :status

  before_create :set_number

  scope :from_to, ->(from, to) {
    where('created_at >= ? AND created_at < ?',
          from.to_datetime.beginning_of_day,
          to.to_datetime.end_of_day)
  }

  scope :ready_to_delivery_from_to, ->(from, to) {
    where('ready_to_delivery_at >= ? AND ready_to_delivery_at < ?',
          from.to_datetime.beginning_of_day,
          to.to_datetime.end_of_day)
  }
  scope :delivered, ->() { where('status = ?', 'delivered') }
  scope :at_status, ->(status) { where('status = ?', status) }
  scope :at_year_at_month, ->(year, month) { where('orders.created_at >= ? AND orders.created_at < ?', "#{year}/#{month}/01".to_datetime, "#{year}/#{month}/01".to_datetime.end_of_month) }

  def create_unseens(current_user)
    User.where('id != ?', current_user.id).each do |user|
      unseens.find_or_create_by(user_id: user.id)
    end
  end

  def unseen_for(user)
    unseens.where('user_id = ?', user.id).first
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
