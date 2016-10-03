class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :wz
  has_many :resources

  has_paper_trail

  accepts_nested_attributes_for :resources

  validates_presence_of :description, :user_id, :quantity, :delivery_request_date, :status, :type

  before_update :check_status
  before_create :check_status

  scope :at_date, ->(date) { where('created_at >= ? AND created_at < ?', date.beginning_of_day, date.beginning_of_day + 1.day) }
  scope :delivered_at, ->(date) { where('delivery_date >= ? AND delivery_date < ?', date.beginning_of_day, date.beginning_of_day + 1.day) }
  scope :at_status, ->(status) { where('status = ?', status) }
  scope :at_year_at_month, ->(year, month) { where('created_at >= ? AND created_at < ?', "#{year}/#{month}/01".to_datetime, "#{year}/#{month.to_i + 1}/01".to_datetime) }

  def check_status
    if status == 'not_confirmed' && delivery_request_date.try(:to_date) == confirmation_date.try(:to_date)
      self.status = 'ordered'
    end
  end
end
