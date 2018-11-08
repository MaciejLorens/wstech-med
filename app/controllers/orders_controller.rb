class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :history]

  def ordered
    @orders = Order
               .includes(:purchaser, :user)
               .where(status: 'ordered')
               .order(created_at: :desc)
  end

  def ready_to_delivery
    @order = Order
               .includes(:resources, :user)
               .where(status: 'ready_to_delivery')
               .order(created_at: :desc)
  end

  def delivered
    @order = Order
               .includes(:resources, :user)
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

    @order = Order.new(order_params)

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
    @order.update(status: 'deleted', deleted_at: Time.now, deleted_by: "#{current_user.first_name} #{current_user.last_name}")
    if status == :delivered
      redirect_to params[:referer]
    else
      redirect_to action: status
    end
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
    refactored_params = params.require(:order).permit!

    purchaser_name = refactored_params[:purchaser_name]
    purchaser = Purchaser.find_or_create_by(name: purchaser_name)

    refactored_params.delete(:purchaser_name)
    refactored_params.merge!(user_id: current_user.id, purchaser_id: purchaser.id)

    Rails.logger.info "   ===== refactored_params : #{refactored_params}"

    refactored_params
  end

  def resources_params
    [params[:order][:image1], params[:order][:image2], params[:order][:image3], params[:order][:url1], params[:order][:url2], params[:order][:url3]].compact
  end
end