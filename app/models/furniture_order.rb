class FurnitureOrder < Order

  after_create :set_number

  private

  def set_number
    time = Time.now
    self.update_attribute(:number, "ZF/#{time.year}/#{time.month}/#{time.day}/#{self.id}")
  end

end
