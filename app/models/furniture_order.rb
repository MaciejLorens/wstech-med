class FurnitureOrder < Order

  after_create :set_number

  private

  def set_number
    time = Time.now
    self.update_column(:number, "ZS/#{time.strftime('%y')}/#{time.month}/#{time.day}/#{self.id}")
  end

end
