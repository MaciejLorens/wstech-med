class Item < ActiveRecord::Base

  belongs_to :order

  validates_presence_of :description, :quantity, :color

  scope :visible, -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }

  has_paper_trail

  def hide
    self.update(hidden: true, hidden_at: Time.now)
  end

  def visible?
    !self.hidden
  end

end
