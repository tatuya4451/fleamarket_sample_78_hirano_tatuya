class ItemsController < ApplicationController
  require 'payjp'
  before_action :index_category_set, only: :index

  def index
    @parents = Category.where(ancestry: nil)
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
      redirect_to root_path
     else
      render "new"
     end
    
  end

  def show
  end

  def purchase
    
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

  private
  def item_params
    params.require(:item).permit(:name, :introduce, :brand, :price, :prefecture_id, :preparation_id, :condition_id,:category_id, :delivery_id, images_attributes: [:url],).merge(saler_id:current_user.id)
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
end

