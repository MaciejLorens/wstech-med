class HomeController < ApplicationController

  def index
    @assemblers = User.where(admin: false)
  end

  def search
    q = "%#{params[:query]}%"

    @orders = Order
                .joins(:items)
                .where('orders.number ILIKE ? OR items.product ILIKE ? OR items.model ILIKE ? OR items.options ILIKE ?', q, q, q, q)
                .order(created_at: :desc)

    render partial: 'search'
  end

end
