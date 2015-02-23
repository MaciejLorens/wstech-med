class Order < ActiveRecord::Base
  belongs_to :user
  has_many :resources

  before_update :check_status

  private

  def check_status
    if status == 'not_confirmed' && delivery_request_date.try(:to_date) == confirmation_date.try(:to_date)
      self.status = 'ordered'
    end
  end
end
