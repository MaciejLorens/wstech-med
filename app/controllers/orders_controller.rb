class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :history]
  before_action :set_sorting, only: [:ordered, :ready_to_delivery, :delivered, :deleted]

  def ordered
    @orders = Order
                .includes(:purchaser, :user, :items)
                .where(status: 'ordered')
                .order(@sorting)
  end

  def ready_to_delivery
    @orders = Order
                .includes(:purchaser, :user, :items)
                .where(status: 'ready_to_delivery')
                .order(@sorting)
  end

  def delivered
    @orders = Order
                .includes(:purchaser, :user, :items)
                .where(status: 'delivered')
                .at_year_at_month(params[:year], params[:month])
                .order(@sorting)
  end

  def deleted
    @orders = Order
                .includes(:purchaser, :user, :items)
                .where(status: 'deleted')
                .at_year_at_month(params[:year], params[:month])
                .order(@sorting)
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
      redirect_to root_path, notice: 'Zamówienie zostało stworzone.'
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)

      if order_params['items_attributes']
        order_params['items_attributes'].each do |index, item|
          if item['id'].present? && item['description'].blank? && item['quantity'].blank? && item['price'].blank?
            @order.items.find(item['id'].to_i).hide
          end
        end
      end

      redirect_to params[:referer], notice: 'Zamówienie zostało uaktualnione.'
    else
      render :edit
    end
  end

  def destroy
    status = @order.status.to_sym
    @order.update(status: 'deleted', deleted_at: Time.now, deleted_by_id: current_user.id)
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

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_sorting
    @sorting = case params[:sort]
               when 'id' then 'id'
               when 'description' then 'items.description'
               when 'quantity' then 'items.quantity'
               when 'price' then 'items.price'
               when 'user' then 'users.last_name'
               when 'purchaser' then 'purchasers.name'
               when 'created_at' then 'created_at'
               when 'delivery_request_date' then 'delivery_request_date'
               when 'ready_to_delivery_at' then 'ready_to_delivery_at'
               when 'delivered_at' then 'delivered_at'
               when 'invoice_number' then 'invoice_number'
               when 'serial_number' then 'serial_number'
               when 'shipping_address' then 'shipping_address'
               else
                 'created_at'
               end

    @sorting += " #{params[:order] || 'desc'}"
  end

  def order_params
    refactored_params = params.require(:order).permit!

    purchaser_name = refactored_params[:purchaser_name]
    if purchaser_name.present?
      purchaser = Purchaser.find_or_create_by(name: purchaser_name)
      refactored_params.delete(:purchaser_name)
      refactored_params.merge!(purchaser_id: purchaser.id)
    end

    refactored_params.merge!(user_id: current_user.id, updated_at: Time.now)
    refactored_params
  end

end
