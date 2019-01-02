module QueryHelper

  def filter_query
    query = "orders.id IS NOT NULL"

    if params[:f_created_at_from].present?
      value = params[:f_created_at_from].try(:to_date)
      query += " AND orders.created_at >= '#{value.beginning_of_day}'"
    end

    if params[:f_created_at_to].present?
      value = params[:f_created_at_to].try(:to_date)
      query += " AND orders.created_at <= '#{value.end_of_day}'"
    end

    if params[:f_number].present?
      query += " AND orders.number LIKE '%#{params[:f_number]}%'"
    end

    if params[:f_description].present?
      query += " AND items.description LIKE '%#{params[:f_description]}%'"
    end

    if params[:f_invoice_number].present?
      query += " AND orders.invoice_number LIKE '%#{params[:f_invoice_number]}%'"
    end

    if params[:f_serial_number].present?
      query += " AND orders.serial_number LIKE '%#{params[:f_serial_number]}%'"
    end

    if params[:f_user_id].present?
      query += " AND orders.user_id = #{params[:f_user_id]}"
    end

    if params[:f_purchaser_id].present?
      query += " AND orders.purchaser_id = #{params[:f_purchaser_id]}"
    end

    query
  end

end