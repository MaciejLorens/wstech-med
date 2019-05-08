class Purchaser < ActiveRecord::Base

  has_many :orders

  scope :visible, -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }

  validates_presence_of :name

  def hide!
    update(hidden: true, hidden_at: Time.current)
  end

  def unhide!
    update(hidden: false, hidden_at: nil)
  end
end
