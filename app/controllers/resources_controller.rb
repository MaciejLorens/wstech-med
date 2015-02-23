class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def create
    metal_order = MetalOrder.find(params[:metal_order_id])
    @resource = metal_order.resources.new(resource_params)

    if @resource.save
      redirect_to controller: 'metal_orders', action: :edit, id: metal_order.id
    else
      render :new
    end
  end

  def destroy
    metal_order = MetalOrder.find(params[:metal_order_id])
    @resource.destroy
    redirect_to controller: 'metal_orders', action: :edit, id: metal_order.id
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit!
  end
end
