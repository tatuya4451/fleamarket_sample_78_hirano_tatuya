class ItemsController < ApplicationController
  require 'payjp'
  Payjp.api_key = Rails.application.credentials.PAYJP[:PRIVATE_KEY]

  before_action :index_category_set, only: :index
  before_action :set_item_search_query
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :set_parent
  before_action :set_item_find,only: [:show, :edit, :destroy]

  def index
    @latest_items = Item.limit(4).order("id DESC")
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
  
     else
      render "new"
     end  
     @image = Image.find_by(item_id: @item.id)
  end

  def search
    @search = Item.ransack(params[:q])
    @search_items = @search.result(distance: true).order(created_at: "DESC") 
  end
  

  def show
    @grandchild = Category.find(@item.category_id)
    @child = @grandchild.parent
    @parent = @child.parent if @child
    @item = Item.find(params[:id])
    @items = Item.all.includes(:user)
    @bookmarks_num = Bookmark.where(item_id: params[:id]).count
  end

  def edit
    @grandchild_category = Category.find(@item.category_id)
    @parents_category = Category.where(ancestry: nil)
    # item.edit(item_params)

    @child_delivery = Delivery.find(@item.delivery_id)
    @parents_delivery = Delivery.where(ancestry: nil)
    
    # if user_signed_in? &&  current_user.id = @item.saler_id 
    #   redirect_to edit_item_path
    # else 
    #   redirect_to item_path
    # end
  end

  def destroy
    @item.destroy
    @delivery = Delivery.all
    redirect_to root_path
  end

  def update
    item = Item.find(params[:id])
    item.update(update_params)
    if item.saler_id == current_user.id
      redirect_to item_path
    else
      render :edit
    end

    # @item = Item.find(3)
    # #あとで3をitems_idに変える
    # @items = Item.all.includes(:user)
    # @bookmarks_num = Bookmark.where(item_id: 3).count
    # #あとで3をitems_idに変える
  end

  def purchase
    @item = Item.find(params[:id])
    @address = Address.find_by(id:current_user.id)
    @image = Image.find_by(item_id: @item.id)

    if user_signed_in?
      Payjp.api_key = Rails.application.credentials.PAYJP[:PRIVATE_KEY]
      
      card = CreditCard.find_by(user_id: current_user.id)
      if card.blank?
        @default_card_information = nil
      else
        customer = Payjp::Customer.retrieve(card.customer_id)
        @default_card_information = customer.cards.retrieve(card.card_id)
        
        @card_brand = @default_card_information.brand
        case @card_brand
        when "Visa"
          @card_src = "cards/visa.png"
        when "JCB"
          @card_src = "cards/jcb.png"
        when "MasterCard"
          @card_src = "cards/master.png"
        when "American Express"
          @card_src = "cards/amex.png"
        when "Diners Club"
          @card_src = "cards/diners.png"
        when "Discover"
          @card_src = "cards/discover.png"
        end
      end
    end
  end

  def bookmarks
    @items = current_user.bookmark_items.include(:user)
  end

  def purchase_done
    @item = Item.find(params[:id])
    @image = Image.find_by(item_id: @item.id)
  end

  def pay
    # 支払い情報の作成
    card = CreditCard.find_by(user_id: current_user.id)
    @item = Item.find(params[:id])
    #保管した顧客IDでpayjpから情報取得
    customer = Payjp::Customer.retrieve(card.customer_id)
    #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    Payjp::Charge.create(
      amount: @item.price, #支払い金額
      customer: card.customer_id, #支払うユーザのpayjp顧客ID
      currency: 'jpy', #通貨の指定
    )
    @item = Item.find(params[:id])
    @item.update( buyer_id: current_user.id)
    redirect_to purchase_done_item_path(@item.id)
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduce, :brand, :price, :prefecture_id, :preparation_id, :condition_id,:category_id, :delivery_id, images_attributes: [:url],).merge(saler_id:current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def index_category_set
    array = [1, 200]
      for num in array do
        search_anc = Category.where('ancestry LIKE(?)', "#{num}/%")
        ids = []
        search_anc.each do |i|
          ids << i[:id]
        end
        items = Item.where(category_id: ids).order("id DESC").limit(4)
        instance_variable_set("@cat_no#{num}", items)
      end
   end

   def update_params
    params.require(:item).permit(:name, :introduce, :brand, :price, :prefecture_id, :preparation_id, :condition_id,:category_id, :delivery_id, images_attributes: [:url , :id , :_destroy]).merge(saler_id:current_user.id)
  end

  def set_item_find
    @item = Item.find(params[:id])
  end

end

