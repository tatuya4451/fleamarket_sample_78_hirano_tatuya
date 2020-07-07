class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
     @item = Item.new(item_params)
     if @item.save
      redirect_to root_path
     else
      render :new
     end
  end

  def show
  end

  def purchase
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduce, :brand, :price, :prefecture_id, :preparation_id, :condition_id, images_attributes: [:url])
  end  
end

