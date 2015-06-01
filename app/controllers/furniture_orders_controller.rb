class FurnitureOrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :history]

  def inquiry
    @furniture_order = FurnitureOrder.where(status: 'inquiry').order(created_at: :asc)
  end

  def proposition
    @furniture_order = FurnitureOrder.where(status: 'proposition').order(created_at: :asc)
  end

  def not_confirmed
    @furniture_order = FurnitureOrder.where(status: 'not_confirmed').order(created_at: :asc)
  end

  def ordered
    @furniture_order = FurnitureOrder.where(status: 'ordered').order(created_at: :asc)
  end

  def delivered
    @furniture_order = FurnitureOrder.where(status: 'delivered').order(created_at: :asc)
  end

  def history
  end

  def show
  end

  def new
    @furniture_order = FurnitureOrder.new(user_id: current_user.id)
  end

  def new_inquiry
    @furniture_order = FurnitureOrder.new(user_id: current_user.id, status: 'inquiry')
    render :new
  end

  def edit
  end

  def create
    @furniture_order = FurnitureOrder.new(furniture_order_params.merge(user_id: current_user.id))

    if @furniture_order.save
      resources_params.each do |resource|
        @furniture_order.resources.create(resource) if resource['image'].present? || resource['link'].present?
      end
      redirect_to params[:referer], notice: 'Zamówienie zostało stworzone.'
    else
      render :new
    end
  end

  def update
    if @furniture_order.update(furniture_order_params)
      redirect_to params[:referer], notice: 'Zamówienie zostało zaktualizowane.'
    else
      render :edit
    end
  end

  def destroy
    @furniture_order.destroy
    redirect_to action: @furniture_order.status.to_sym, notice: 'Zamówienie zostało usunięte.'
  end

  private

  def set_order
    @furniture_order = FurnitureOrder.find(params[:id])
  end

  def furniture_order_params
    params.require(:furniture_order).permit!.except(:image1, :image2, :image3, :url1, :url2, :url3)
  end

  def resources_params
    [params[:furniture_order][:image1], params[:furniture_order][:image2], params[:furniture_order][:image3], params[:furniture_order][:url1], params[:furniture_order][:url2], params[:furniture_order][:url3]].compact
  end
end
