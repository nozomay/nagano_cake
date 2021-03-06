class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
  #   @order = Order.find(params[:id])
  #   if @order.update(order_params)
  #     flash[:notice] = "注文ステータスを変更しました"
  #     redirect_to admin_order_path
  #   else
  #     render :show
  #   end
  # end

    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      if @order.paid?
        @order_details.each do |order_detail|
          order_detail.standby!
        end
      end
      flash[:notice] = "注文ステータスを変更しました"
      redirect_to admin_order_path
    else
        render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
