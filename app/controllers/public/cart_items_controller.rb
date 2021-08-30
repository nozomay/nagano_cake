class Public::CartItemsController < ApplicationController
  #before_action :authenticate_user!

  def index
    @cart_items = current_public.cart_item

  end

  def update
    @cart_item.update(amount: params[:amount].to_i)
      flash[:notice] = '数量を変更しました'
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item.destroy
    flash[:notice] = "  を削除しました"
    redirect_to public_cart_items_path
  end

  def all_destroy
    @cart_items = current_public.cart_items
    @cart_items.destroy_all
    flash[:alert] = "カート内の商品を全て削除しました"
    redirect_to public_cart_items_path
  end

  def create
    # 1. 追加した商品がカート内に存在するかの判別
    @cart_item=Cart_item.find_by(params[:id])
    # 存在した場合
    if @cart_item.present?
      # 2. カート内の個数をフォームから送られた個数分追加する
      @cart_item.amount += paramd[:amount].to_i
      @cart_item.save
　    redirect_to current_cart
    else # 存在しなかった場合
      # カートモデルにレコードを新規作成する
      @cart_item = current_public.cart_items.new(params_cart_item)
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
