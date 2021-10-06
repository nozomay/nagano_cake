class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!

  def index #配送先登録/一覧画面
   @shipping_addresses = Address.all
   @shipping_address = Address.new
  end

  def create #配送先の登録
    @shipping_addresses = Address.all
    @shipping_address = Address.new(shipping_address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      flash[:notice] = "配送先を新たに登録しました"
      redirect_to shipping_addresses_path
    else
      render :index
    end
  end

  def edit #配送先編集画面
    @shipping_address = Address.find(params[:id])
  end

  def update #配送先の更新
    @shipping_address = Address.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      flash[:notice] = "配送先を更新しました"
      redirect_to shipping_addresses_path
    else
      render :edit
    end
  end

  def destroy #配送先の削除
    @shipping_address = Address.find(params[:id])
    @shipping_address.destroy
    redirect_to shipping_addresses_path
  end

  private

  def shipping_address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
