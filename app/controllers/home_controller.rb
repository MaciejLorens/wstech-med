class HomeController < ApplicationController

  def index

  end

  def search
    @orders = Order
                .joins(:items)
                .where('items.description LIKE ?', "%#{params[:query].downcase}%")
                .includes(:purchaser, :user, :items)
                .order(created_at: :desc)

    render json: {content: render_to_string(partial: 'search')}
  end

end
