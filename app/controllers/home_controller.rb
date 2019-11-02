class HomeController < ApplicationController

  def index
    @assemblers = User.where(admin: false)
  end

  def search
    q = "%#{params[:query].downcase}%"

    @orders = Order
                .joins(:items)
                .where('orders.number LIKE ? OR items.product LIKE ? OR items.model LIKE ? OR items.options LIKE ?', q, q, q, q)
                .includes(:purchaser, :user, :items)
                .order(created_at: :desc)

    render partial: 'search'
  end

end
