class Public::OrdersController < ApplicationController
  #before_action :authenticate_user!
  
  def new #注文情報入力画面(支払方法・配送先の選択)
      @order = Order.new
    	@addresses = Address.where(customer: current_customer)
  end

  def confirm #注文情報確認画面
  　@order = Order.new(order_params)
    render :new if @order.invalid?
  end

  def thanks #注文完了画面
  end

  def create #注文確定処理
    @order = current_customer.orders.new(order_params)
    @order.save
    redirect_to thanks_customers_orders_path
  end

  def index #注文履歴画面
  　@orders = current_customer.orders
  end

  def show #注文履歴詳細画面
  　@order = Order.find(params[:_id])
  　@order_details = @order.order_details
  end
end