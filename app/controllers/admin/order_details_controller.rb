class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    # @order_detail = OrderDetail.find(params[:id])
    # if @order_detail.update(order_detail_params)
    #     flash[:notice] = "製作ステータスを変更しました"
    #     redirect_to admin_order_path(@order_detail.order.id)
    # else
    #     render :show
    # end

    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
      if @order_detail.making?
        @order.making!
        # ↓order_detailsの数とmaking_statusがfinishになった数が同じ時
      elsif @order.order_details.count == @order.order_details.where(making_status: "finish").count
        @order.preparation!
      end

      flash[:notice] = "注文ステータスを変更しました"
      redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
