class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_user!
  
  def index #配送先登録/一覧画面
   @shipping_address = current_customer.shipping_address
   @shipping_address = ShippingAddress.new
  end

  def edit #配送先編集画面
    @shipping_address = shipping_address.find(params[:id])

  end

  def create #配送先の登録
    @shipping_address = shipping_address.new
    @shipping_address.customer_id = current_customer.id
    @shipping_addresses = current_customer.shipping_address
    if @shipping_address.save
      flash[:notice] = "配送先を新たに登録しました"
    　redirect_to customers_shipping_addresses_path
    else
      @shipping_addresses = current_customer.shipping_address
      render :index
    end

  def update #配送先の更新
    @shipping_address = shipping_address.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      flash[:notice] = "配送先を更新しました"
      redirect_to customers_hipping_address
    else
      render :edit
    end
  end

  def destroy #配送先の削除
    @shipping_address = shipping_address.find(params[:id])
    @shipping_address.destroy
    redirect_to customers_hipping_address

  end

  private

  def shipping_address_params
    params.require(:shipping_address).rermit(:name, :postal_code, :address)
  end
  end
end
