class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
     @customer = current_customer
     @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "お客様情報を変更しました"
      redirect_to customers_path
    else
      render :edit
    end
  end

  def quit #退会確認画面
    @customer = current_customer
  end

  def out #顧客の退会処理(ステータスの更新)
    @customer = current_customer
    @customer.update(is_active: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :encrypted_password, :postal_code, :address, :telephone_number, :is_active)
  end
end
