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

  def ordered_sort_link(text, param)
    img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_none.png"></img>'
    asc_param = 'asc'

    if params[:sort] == param && params[:order].present?
      img = "<img src='https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_#{params[:order]}.png'></img>"
      asc_param = params[:order] == 'asc' ? 'desc' : 'asc'
    end

    link_to "#{text} #{img}".html_safe, ordered_orders_path(sort: param, order: asc_param), class: 'sorting-btn'
  end

  def ready_to_delivery_sort_link(text, param)
    img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_none.png"></img>'
    asc_param = 'asc'

    if params[:sort] == param && params[:order].present?
      img = "<img src='https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_#{params[:order]}.png'></img>"
      asc_param = params[:order] == 'asc' ? 'desc' : 'asc'
    end

    link_to "#{text} #{img}".html_safe, ready_to_delivery_orders_path(sort: param, order: asc_param), class: 'sorting-btn'
  end

  def delivered_sort_link(text, param)
    img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_none.png"></img>'
    asc_param = 'asc'

    if param == 'created_at' && params[:sort].blank?
      img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_desc.png"></img>'
    end

    if params[:sort] == param && params[:order].present?
      img = "<img src='https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_#{params[:order]}.png'></img>"
      asc_param = params[:order] == 'asc' ? 'desc' : 'asc'
    end

    link_to "#{text} #{img}".html_safe, delivered_orders_path(sort: param, order: asc_param, year: params[:year], month: params[:month]), class: 'sorting-btn'
  end

  def deleted_sort_link(text, param)
    img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_none.png"></img>'
    asc_param = 'asc'

    if param == 'created_at' && params[:sort].blank?
      img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_desc.png"></img>'
    end

    if params[:sort] == param && params[:order].present?
      img = "<img src='https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_#{params[:order]}.png'></img>"
      asc_param = params[:order] == 'asc' ? 'desc' : 'asc'
    end

    link_to "#{text} #{img}".html_safe, deleted_orders_path(sort: param, order: asc_param, year: params[:year], month: params[:month]), class: 'sorting-btn'
  end

end
