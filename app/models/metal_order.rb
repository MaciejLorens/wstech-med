class MetalOrder < Order

  before_create :set_number

  private

  def set_number
    time = Time.now
    self.number = "ZM/#{time.strftime('%y')}/#{time.month}/#{time.day}/#{self.id}"
  end

end
