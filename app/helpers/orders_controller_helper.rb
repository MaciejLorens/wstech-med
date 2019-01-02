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

  def ordered_sort_link(text, field)
    img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_none.png"></img>'

    if params[:s_field] == field && params[:s_order].present?
      img = "<img src='https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_#{params[:s_order]}.png'></img>"
    end

    link_to "#{text} #{img}".html_safe, '#', class: "sorting-btn #{params[:s_order]}", :'data-field' => field
  end

  def ready_to_delivery_sort_link(text, field)
    img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_none.png"></img>'

    if params[:s_field] == field && params[:s_order].present?
      img = "<img src='https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_#{params[:s_order]}.png'></img>"
    end

    link_to "#{text} #{img}".html_safe, '#', class: "sorting-btn #{params[:s_order]}", :'data-field' => field
  end

  def delivered_sort_link(text, field)
    img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_none.png"></img>'

    if field == 'created_at' && params[:s_field].blank?
      img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_desc.png"></img>'
    end

    if params[:s_field] == field && params[:s_order].present?
      img = "<img src='https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_#{params[:s_order]}.png'></img>"
    end

    link_to "#{text} #{img}".html_safe, '#', class: "sorting-btn #{params[:s_order]}", :'data-field' => field
  end

  def deleted_sort_link(text, field)
    img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_none.png"></img>'

    if field == 'created_at' && params[:s_field].blank?
      img = '<img src="https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_desc.png"></img>'
    end

    if params[:s_field] == field && params[:s_order].present?
      img = "<img src='https://s3-eu-west-1.amazonaws.com/wstech-med-production/website/sort_#{params[:s_order]}.png'></img>"
    end

    link_to "#{text} #{img}".html_safe, '#', class: "sorting-btn #{params[:s_order]}", :'data-field' => field
  end

  def options_for_users
    User.all.map do |user|
      [user.first_name, user.id]
    end
  end

  def options_for_purchasers
    Purchaser.all.map do |purchaser|
      [purchaser.name, purchaser.id]
    end
  end

end
