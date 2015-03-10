class FurnitureOrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :history]

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

  def edit
  end

  def create
    @furniture_order = FurnitureOrder.new(furniture_order_params.merge(user_id: current_user.id))

    if @furniture_order.save
      redirect_to action: @furniture_order.status.to_sym, notice: 'Zamówienie zostało stworzone.'
    else
      render :new
    end
  end

  def update
    if @furniture_order.update(furniture_order_params)
      redirect_to action: @furniture_order.status.to_sym, notice: 'Zamówienie zostało zaktualizowane.'
    else
      render :edit
    end
  end

  def destroy
    @furniture_order.destroy
    redirect_to action: :not_confirmed, notice: 'Zamówienie zostało usunięte.'
  end

  private

  def set_order
    @furniture_order = FurnitureOrder.find(params[:id])
  end

  def furniture_order_params
    params.require(:furniture_order).permit!
  end
end
