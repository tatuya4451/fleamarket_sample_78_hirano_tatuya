class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item.images.new
    @category_parent_array = ["選択してください"]
     Category.where(ancestry: nil).each do |parent|
       @category_parent_array << parent.name
       end
   
  end
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
 end

 def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
   @category_grandchildren = Category.find("#{params[:child_id]}").children
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
    params.require(:item).permit(:name, :introduce, :brand, :price, :prefecture_id, :preparation_id, :condition_id,:category_id,images_attributes: [:url],)
  end  
end

