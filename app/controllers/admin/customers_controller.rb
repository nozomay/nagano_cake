class Admin::CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @customers = Public.all.page(params[:page]).reverse_order
  end

  def show
    @customer = Public.find(params[:id])
  end

  def edit
    @customer = Public.find(params[:id])

  end

  def update
    @customer = Public.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を変更しました"
      redirect_to admin_customer_path
    else
        render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_active)
  end
end
