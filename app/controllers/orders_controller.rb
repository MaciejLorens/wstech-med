class OrdersController < ApplicationController

  before_action :authorize, only: [:ready_to_delivery, :delivered, :deleted, :history, :show, :new, :edit, :create, :destroy, :download]
  before_action :set_order, only: [:show, :edit, :update, :destroy, :history]
  before_action :set_sorting, only: [:ordered, :ready_to_delivery, :delivered, :deleted]

  def ordered
    @orders = Order
                .includes(:purchaser, :items, :user)
                .joins(:items)
                .joins('LEFT OUTER JOIN unseens ON orders.id = unseens.order_id')
                .where(status: 'ordered')
                .where(filter_query)
                .order(@sorting)
  end

  def ready_to_delivery
    @orders = Order
                .includes(:purchaser, :user, :items)
                .where(status: 'ready_to_delivery')
                .where(filter_query)
                .order(@sorting)
  end

  def delivered
    @orders = Order
                .includes(:purchaser, :user, :items)
                .where(status: 'delivered')
                .where(filter_query)
                .order(@sorting)
  end

  def deleted
    @orders = Order
                .includes(:purchaser, :user, :items)
                .where(status: 'deleted')
                .where(filter_query)
                .order(@sorting)
  end

  def history
    unseen = @order.unseen_for(current_user)
    unseen.destroy if unseen.present?
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
      @order.create_unseens(current_user)
      redirect_to root_path, notice: 'Zamówienie zostało stworzone.'
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      @order.create_unseens(current_user)

      if order_params['items_attributes']
        order_params['items_attributes'].each do |index, item|
          if item['id'].present? && item['description'].blank? && item['quantity'].blank? && item['color'].blank?
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
    @order.create_unseens(current_user)

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
    @sorting = case params[:s_field]
               when 'id' then 'orders.id'
               when 'description' then 'items.description'
               when 'quantity' then 'items.quantity'
               when 'color' then 'items.color'
               when 'user' then 'orders.user_id'
               when 'purchaser' then 'orders.purchaser_id'
               when 'created_at' then 'orders.created_at'
               when 'delivery_request_date' then 'orders.delivery_request_date'
               when 'ready_to_delivery_at' then 'orders.ready_to_delivery_at'
               when 'delivered_at' then 'orders.delivered_at'
               when 'invoice_number' then 'orders.invoice_number'
               when 'serial_number' then 'orders.serial_number'
               when 'shipping_address' then 'orders.shipping_address'
               else
                 'orders.created_at'
               end

    @sorting += " #{params[:s_order] || 'desc'}"
  end

  def order_params
    refactored_params = params.require(:order).permit!

    purchaser_name = refactored_params[:purchaser_name]
    if purchaser_name.present?
      purchaser = Purchaser.find_or_create_by(name: purchaser_name)
      refactored_params.delete(:purchaser_name)
      refactored_params.merge!(purchaser_id: purchaser.id)
    end

    if params[:code].present?
      worker = User.where(code: params[:code]).first
      if worker.present?
        refactored_params[:delivered_by] = worker.id
      else
        return
      end
    end

    refactored_params.merge!(user_id: current_user.id, updated_at: Time.now)
    refactored_params
  end

end
