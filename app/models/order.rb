class Order < ActiveRecord::Base
  belongs_to :user
  has_many :resources

  has_paper_trail

  validates_presence_of :description, :user_id, :quantity, :delivery_request_date, :status, :type

  before_update :check_status

  def check_status
    if status == 'not_confirmed' && delivery_request_date.try(:to_date) == confirmation_date.try(:to_date)
      self.status = 'ordered'
    end
  end
end
