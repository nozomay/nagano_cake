class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_cart
    
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
    @cart_item = current_public.cart_items.new(params_cart_item)
  end
end
