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

    if params[:f_user_id].present?
      query += " AND orders.user_id = #{params[:f_user_id]}"
    end

    if params[:f_purchaser_id].present?
      query += " AND orders.purchaser_id = #{params[:f_purchaser_id]}"
    end

    query
  end

  def sorting_query(default = nil)
    query = default || "created_at DESC"

    if params[:s_field].present? && params[:s_order].present?
      query = "#{params[:s_field]} #{params[:s_order]}"
    end

    query
  end

end
