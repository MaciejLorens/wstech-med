class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :history]

  def ordered
    @order = Order.where(status: 'ordered').order(created_at: :desc)
  end

  def ready_to_delivery
    @order = Order
               .includes(:resources, :user, :wzs)
               .where(status: 'ready_to_delivery')
               .order(created_at: :desc)
  end

  def delivered
    @order = Order
               .includes(:resources, :user, :wzs)
               .where(status: 'delivered')
               .at_year_at_month(params[:year], params[:month])
               .order(created_at: :desc)
  end

  def history
  end

  def show
  end

  def new
    @order = Order.new(user_id: current_user.id)
  end

  def edit
  end

  def create
    @order = Order.new(order_params.merge(user_id: current_user.id))

    if @order.save
      resources_params.each do |resource|
        @order.resources.create(resource) if resource['image'].present? || resource['link'].present?
      end
      redirect_to '/', notice: 'Zamówienie zostało stworzone.'
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to params[:referer], notice: 'Zamówienie zostało zaktualizowane.'
    else
      render :edit
    end
  end

  def destroy
    status = @order.status.to_sym
    if status == :delivered
      # === TODO:Maciej:
      # status = @order.full_in_wz? ? :delivered_with_wz : :delivered_without_wz
    end
    @order.update(status: 'deleted', deleted_at: Time.now, deleted_by: "#{current_user.first_name} #{current_user.last_name}")

    # === TODO:Maciej: 
    # if status == :delivered_with_wz
    #   redirect_to params[:referer]
    # else
      redirect_to action: status
    # end
  end

  def download
    respond_to do |format|
      format.csv { send_data Order.to_csv(params[:status]) }
    end
  end

  def deleted
    @order = Order.where(status: 'deleted').order(created_at: :desc)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit!.except(:image1, :image2, :image3, :url1, :url2, :url3)
  end

  def resources_params
    [params[:order][:image1], params[:order][:image2], params[:order][:image3], params[:order][:url1], params[:order][:url2], params[:order][:url3]].compact
  end
end
