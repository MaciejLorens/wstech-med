module OrdersControllerHelper
  def date(date)
    date.localtime.strftime('%d-%m-%Y') if date.present?
  end

  def date_time(date)
    date.localtime.strftime('%d-%m-%Y %H:%M') if date.present?
  end

  def status(order)
    case order.status
      when 'inquiry' then 'Zapytanie'
      when 'proposition' then 'Oferta'
      when 'not_confirmed' then 'Niezatwierdzone'
      when 'ordered' then 'Zamówione'
      when 'delivered' then 'Zrealizowane'
    end
  end

  def request_date_match(order)
    'red' if date(order.delivery_request_date) != date(order.confirmation_date)
  end
end
