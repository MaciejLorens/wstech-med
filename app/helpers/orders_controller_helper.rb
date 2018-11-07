module OrdersControllerHelper
  def date(date)
    date.localtime.strftime('%d-%m-%Y') if date.present?
  end

  def date_time(date)
    date.localtime.strftime('%d-%m-%Y %H:%M') if date.present?
  end

  def status(order)
    case order.status
      when 'ordered' then 'Zamówione'
      when 'ready_to_delivery' then 'Gotowe do wysyłki'
      when 'delivered' then 'Zrealizowane'
      when 'deleted' then 'Usunięte'
    end
  end

end
