class ItemsController < ApplicationController
  def index
    @parents = Category.where(ancestry: nil)
  end

  def new
    @item = Item.new
    @item.images.new

  end
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def get_delivery_children
    @delivery_children = Delivery.find(params[:parent_id]).children
  end

  def create
    
     @item = Item.new(item_params)
     if @item.save
      redirect_to root_path
     else
      render "new"
     end
    
  end

  def show
  end

  def purchase
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduce, :brand, :price, :prefecture_id, :preparation_id, :condition_id,:category_id, :delivery_id, images_attributes: [:url],).merge(saler_id:current_user.id)
  end  
end

