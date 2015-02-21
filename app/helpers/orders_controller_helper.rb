module OrdersControllerHelper
  def date(date)
    date.strftime('%d-%m-%Y') if date.present?
  end
end
