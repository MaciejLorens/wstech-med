class MetalOrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def not_confirmed
    @metal_order = MetalOrder.where(status: 'not_confirmed').order(created_at: :asc)
  end

  def ordered
    @metal_order = MetalOrder.where(status: 'ordered').order(created_at: :asc)
  end

  def delivered
    @metal_order = MetalOrder.where(status: 'delivered').order(created_at: :asc)
  end

  def show
  end

  def new
    @metal_order = current_user.metal_orders.new
  end

  def edit
  end

  def create
    @metal_order = current_user.metal_orders.new(order_params)

    if @metal_order.save
      redirect_to action: :not_confirmed, notice: 'Zamówienie zostało stworzone.'
    else
      render :new
    end
  end

  def update
    if @metal_order.update(metal_order_params)
      redirect_to action: @metal_order.status.to_sym, notice: 'Zamówienie zostało zaktualizowane.'
    else
      render :edit
    end
  end

  def destroy
    @metal_order.destroy
    redirect_to action: :not_confirmed, notice: 'Zamówienie zostało usunięte.'
  end

  private

  def set_order
    @metal_order = MetalOrder.find(params[:id])
  end

  def order_params
    params.require(:order).permit!
  end

  def metal_order_params
    params.require(:metal_order).permit!
  end
end
