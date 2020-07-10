class ItemsController < ApplicationController
  def index
    @parents = Category.where(ancestry: nil)
  end

  def new
    @item = Item.new
    @item.images.new
    @category_parent_array = ["選択してください"]
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
    @delivery_parent_array = ["選択してください"]
      Delivery.where(ancestry: nil).each do |parent|
        @delivery_parent_array << parent.method
      end
   
  end
  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def get_delivery_children
    @delivery_children = Delivery.find_by(method: "#{params[:parent_method]}", ancestry: nil).children
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
    params.require(:item).permit(:name, :introduce, :brand, :price, :prefecture_id, :preparation_id, :condition_id,:category_id, :delivery_id, images_attributes: [:url],)
  end  
end

