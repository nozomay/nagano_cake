class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_!

  def update
    @order_detail = OrderDtail.finf(params[:id])
    if @order_detail.update(order_detail_params)
        flash[:notice] = "製作ステータスを変更しました"
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
