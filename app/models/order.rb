class Order < ActiveRecord::Base
  belongs_to :user

  before_update :check_status

  private

  def check_status
    if status == 'not_confirmed' && delivery_request_date.to_date == confirmation_date.to_date
      self.status = 'ordered'
    end
  end
end
