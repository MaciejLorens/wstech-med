class OrdersController < ApplicationController

  before_action :authorize, only: [:ready_to_delivery, :delivered, :deleted, :history, :show, :new, :edit, :create, :destroy, :download, :queue]
  before_action :set_order, only: [:show, :pdf, :edit, :update, :queue, :stages, :finish, :assembly, :suspend, :destroy, :history]
  before_action :set_sorting, only: [:ordered, :ready_to_delivery, :delivered, :deleted]

  def ordered
    @orders = Order
                .includes(:purchaser, :items, :user)
                .joins(:items)
                .where(status: 'ordered')
                .where(filter_query)
                .order(@sorting)
  end

  def production
    @queue_orders = Order
                      .includes(:purchaser, :items, :user)
                      .where(status: 'queue')

    @suspended_orders = Order
                          .includes(:purchaser, :items, :user)
                          .where(status: 'suspended')

    @production_orders = Order
                         .includes(:purchaser, :items, :user)
                         .where(status: 'assembly')
                         .order('orders.delivery_request_date asc')
  end

  def ready_to_delivery
    @orders = Order
                .includes(:purchaser, :user, :items)
                .joins(:items)
                .where(status: 'ready_to_delivery')
                .where(filter_query)
                .order(@sorting)
  end

  def delivered
    @orders = Order
                .includes(:purchaser, :user, :items)
                .joins(:items)
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

  def pdf
    html = render_to_string template: 'orders/pdf', layout: 'pdf', locals: { order: @order }

    options = {
      margin_top: '0.8in',
      margin_right: '0.5in',
      margin_bottom: '0.8in',
      margin_left: '0.5in'
    }

    kit = PDFKit.new(html, options)


    file = kit.to_file("tmp/#{@order.number.gsub('/', '_')}.pdf")
    send_file file
  end

  def new
    @order = Order.new(user_id: current_user.id)
    @purchasers = Purchaser.all.visible.order('name asc')
  end

  def edit
    @purchasers = Purchaser.all.visible.order('name asc')
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
          if item['id'].present? && item['product'].blank? && item['model'].blank? && item['options'].blank? && item['color'].blank? && item['quantity'].blank?
            @order.items.find(item['id'].to_i).hide
          end
        end
      end

      redirect_to params[:referer], notice: 'Zamówienie zostało uaktualnione.'
    else
      render :edit
    end
  end

  def queue
    @order.update(status: 'queue')
    @order.create_unseens(current_user)
    redirect_to action: :ordered
  end

  def stages
    worker = User.where(code: params[:code]).first
    return redirect_to root_path, notice: 'Błędny kod pracownika' unless worker.present?

    @order.update(stages: params[:stages].keys)
    @order.versions.last.update(whodunnit: worker.id)
    @order.create_unseens(current_user)

    redirect_to action: :production
  end

  def finish
    worker = User.where(code: params[:code]).first
    return redirect_to root_path, notice: 'Błędny kod pracownika' unless worker.present?

    @order.update(
      status: 'ready_to_delivery',
      ready_to_delivery_at: Time.now,
      ready_to_delivery_by: worker.id,
      package_dimensions: params[:package_dimensions],
      suspend_message: nil
    )
    @order.versions.last.update(whodunnit: worker.id)
    @order.create_unseens(current_user)

    redirect_to action: :production
  end

  def assembly
    worker = User.where(code: params[:code]).first
    return redirect_to root_path, notice: 'Błędny kod pracownika' unless worker.present?

    @order.update(status: 'assembly')
    @order.versions.last.update(whodunnit: worker.id)
    @order.create_unseens(current_user)

    redirect_to action: :production
  end

  def suspend
    worker = User.where(code: params[:code]).first

    return redirect_to root_path, notice: 'Błędny kod pracownika' unless worker.present?

    @order.update(
      status: 'suspended',
      suspend_message: params[:suspend_message],
    )

    @order.versions.last.update(whodunnit: worker.id)
    @order.create_unseens(current_user)

    redirect_to action: :production
  end

  def destroy
    @order.update(status: 'deleted', deleted_at: Time.now, deleted_by_id: current_user.id)
    @order.create_unseens(current_user)

    redirect_to root_path
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
               when 'id' then
                 'orders.id'
               when 'product' then
                 'items.product'
               when 'model' then
                 'items.model'
               when 'options' then
                 'items.options'
               when 'color' then
                 'items.color'
               when 'quantity' then
                 'items.quantity'
               when 'user' then
                 'orders.user_id'
               when 'purchaser' then
                 'orders.purchaser_id'
               when 'client_order_number' then
                 'orders.client_order_number'
               when 'created_at' then
                 'orders.created_at'
               when 'delivery_request_date' then
                 'orders.delivery_request_date'
               when 'ready_to_delivery_at' then
                 'orders.ready_to_delivery_at'
               when 'delivered_at' then
                 'orders.delivered_at'
               when 'invoice_number' then
                 'orders.invoice_number'
               when 'serial_number' then
                 'orders.serial_number'
               when 'shipping_address' then
                 'orders.shipping_address'
               else
                 'orders.created_at'
               end

    @sorting += " #{params[:s_order] || 'desc'}"
  end

  def order_params
    params.require(:order).permit!
  end

end
