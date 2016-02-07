class WzsController < ApplicationController
  before_filter :authentication

  def new
    @wz = Wz.new
  end

  def index
    @wzs = Wz.all
  end

  def create
    at = wz_params[:created_at].to_datetime
    wz = Wz.at_date(at).first.presence || Wz.create(created_at: at, number: 'sample')

    Order.delivered_at(at).at_status('delivered').each{|order| order.update_attribute(:wz_id, wz.id)}

    redirect_to action: :index, notice: 'WZ została stworzona.'
  end

  def download
    wz = Wz.find(params[:id])
    respond_to do |format|
      format.csv { send_data wz.to_csv }
    end
  end

  private

  def wz_params
    params.require(:wz).permit!
  end

  def authentication
    redirect_to :root unless current_user.admin?
  end
end
