class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end
    
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Added new item."
    redirect_to admin_item_path(@item)
    else
      render :new
    end
  end
  
  def show
  end

  def edit
  end
  
  def update
    if @item.update(item_params)
      flash[:notice] = "success"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:genre_id, :name, :image_id, :introduction, :price, :is_active)
  end
end
