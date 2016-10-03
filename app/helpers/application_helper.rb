module ApplicationHelper
  def name_of_month(number)
    t(Date::MONTHNAMES[number.to_i])
  end

  def name_of_months
    i = 0
    Date::MONTHNAMES[1..-1].map {|month| t(month)}.map{|month| i += 1;  [month, i]}
  end
end
