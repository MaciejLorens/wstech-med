class PurchasersController < ApplicationController
  before_action :set_purchaser, only: [:show, :edit, :update, :destroy]

  def index
    @purchasers = Purchaser.all.visible.order('name asc')
  end

  def show
  end

  def new
    @purchaser = Purchaser.new
  end

  def edit
  end

  def create
    @purchaser = Purchaser.new(purchaser_params)

    if @purchaser.save
      redirect_to purchasers_url, notice: 'Purchaser was successfully created.'
    else
      render :new
    end
  end

  def update
    if @purchaser.update(purchaser_params)
      redirect_to purchasers_url, notice: 'Purchaser was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @purchaser.hide!
    redirect_to purchasers_url, notice: 'Purchaser was successfully destroyed.'
  end

  private

  def set_purchaser
    @purchaser = Purchaser.find(params[:id])
  end

  def purchaser_params
    params.require(:purchaser).permit(:name)
  end

end
