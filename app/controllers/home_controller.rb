class HomeController < ApplicationController

  def index
  end

  def search
    @orders = Order.where('description LIKE ?', "%#{params[:query]}%").includes(:resources, :user, :wz).order(created_at: :desc)
    render json: {content: render_to_string(partial: 'search')}
  end

end
