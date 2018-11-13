class HomeController < ApplicationController

  def index
    @not_admins = User.where(admin: false).includes(orders: :items)

    from = params[:from] || DateTime.now.beginning_of_month
    to = params[:to] || DateTime.now

    @data = {
      labels: @not_admins.map{|u| "#{u.first_name} #{u.last_name}"},
      datasets: [
        {
          label: "My First dataset",
          backgroundColor: color_list.first(@not_admins.count),
          borderColor: "rgba(0,0,0,1)",
          data: @not_admins.map do |u|
            u.orders_price_sum(from, to)
          end
        }
      ]
    }
  end

  def search
    @orders = Order
                .joins(:items)
                .where('items.description LIKE ?', "%#{params[:query].downcase}%")
                .includes(:purchaser, :user, :items)
                .order(created_at: :desc)

    render json: {content: render_to_string(partial: 'search')}
  end

  private

  def color_list
    %w( rgba(255,0,0) rgba(255,128,0) rgba(255,255,0) rgba(128,255,0)
        rgba(0,255,128) rgba(0,255,255) rgba(0,128,255) rgba(128,0,255)
        rgba(255,0,255) rgba(128,128,128))
  end

end
