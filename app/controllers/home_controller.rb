class HomeController < ApplicationController

  def index
  end

  def search
    @orders = Order.where('lower(description) LIKE ?', "%#{params[:query].downcase}%").includes(:resources, :user).order(created_at: :desc)
    render json: {content: render_to_string(partial: 'search')}
  end

end
