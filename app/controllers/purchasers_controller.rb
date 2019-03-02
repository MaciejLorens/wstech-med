class PurchasersController < ApplicationController

  before_action :authorize, only: [:destroy]

  before_action :set_purchaser, only: [:destroy]

  def destroy
    Order.where(purchaser_id: params[:id]).update_all(purchaser_id: 0)
    @purchaser.destroy
    redirect_to '/orders/new'
  end

  private

  def set_purchaser
    @purchaser = Purchaser.find(params[:id])
  end

end
