class Admin::OdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "success"
      redirect_to admin_order_path
    else
        render :show
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
    
end
