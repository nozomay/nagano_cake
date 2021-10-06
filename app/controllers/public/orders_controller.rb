class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new #注文情報入力画面(支払方法・配送先の選択)
      @order = Order.new
    	@addresses = Address.where(customer: current_customer)
  end

  def confirm #注文情報確認画面
    @order = Order.new(order_params)
    #自身の住所
    if params[:order][:select_address_method] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    #登録の住所
    elsif params[:order][:select_address_method] == "2"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    #新規登録
    elsif  params[:order][:select_address_method] == "3"
    end

    @cart_items = current_customer.cart_items
    @orders = Order.all

  end

  def thanks #注文完了画面
  end

  def create #注文確定処理
    @order = current_customer.orders.new(order_params)
    @order.save
    redirect_to thanks_orders_path
  end

  def index #注文履歴画面
    @orders = Order.all
  end

  def show #注文履歴詳細画面
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
  end
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end