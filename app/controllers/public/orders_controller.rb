class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  	@shipping_addresses = ShippingAddress.where(customer: current_customer)
  end
  
  def confirm
  end
  
  def thanks
  end
  
  def create
  end
  
  def index
  end
  
  def show
  end
end
