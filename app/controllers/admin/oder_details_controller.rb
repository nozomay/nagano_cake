class Admin::OderDetailsController < ApplicationController
  before_action :authenticate_user!

  def update
    @order_detail = OrderDtail.finf(params[:id])
    if @order_detail.update(order_detail_params)
        flash[:notice] = "update"
        redirect_to admin_order_path(@order_detail)
    else
        render :show
    end
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:status)
  end
end
