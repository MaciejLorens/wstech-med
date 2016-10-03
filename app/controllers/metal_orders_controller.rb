class MetalOrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :history]

  def inquiry
    @metal_order = MetalOrder.where(status: 'inquiry').order(created_at: :desc)
  end

  def proposition
    @metal_order = MetalOrder.where(status: 'proposition').order(created_at: :desc)
  end

  def not_confirmed
    @metal_order = MetalOrder.where(status: 'not_confirmed').order(created_at: :desc)
  end

  def ordered
    @metal_order = MetalOrder.where(status: 'ordered').order(created_at: :desc)
  end

  def delivered
    @metal_order = MetalOrder.at_year_at_month(params[:year], params[:month]).where(status: 'delivered').order(created_at: :desc)
  end

  def history
  end

  def show
  end

  def new
    @metal_order = MetalOrder.new(user_id: current_user.id)
  end

  def new_inquiry
    @metal_order = MetalOrder.new(user_id: current_user.id, status: 'inquiry')
    render :new
  end

  def edit
  end

  def create
    @metal_order = MetalOrder.new(metal_order_params.merge(user_id: current_user.id))

    if @metal_order.save
      resources_params.each do |resource|
        @metal_order.resources.create(resource) if resource['image'].present? || resource['link'].present?
      end
      redirect_to params[:referer], notice: 'Zamówienie zostało stworzone.'
    else
      render :new
    end
  end

  def update
    if @metal_order.update(metal_order_params)
      redirect_to params[:referer], notice: 'Zamówienie zostało zaktualizowane.'
    else
      render :edit
    end
  end

  def destroy
    @metal_order.destroy
    redirect_to action: @metal_order.status.to_sym, notice: 'Zamówienie zostało usunięte.'
  end

  def download
    respond_to do |format|
      format.csv { send_data MetalOrder.to_csv(params[:status]) }
    end
  end

  private

  def set_order
    @metal_order = MetalOrder.find(params[:id])
  end

  def metal_order_params
    params.require(:metal_order).permit!.except(:image1, :image2, :image3, :url1, :url2, :url3)
  end

  def resources_params
    [params[:metal_order][:image1], params[:metal_order][:image2], params[:metal_order][:image3], params[:metal_order][:url1], params[:metal_order][:url2], params[:metal_order][:url3]].compact
  end
end
