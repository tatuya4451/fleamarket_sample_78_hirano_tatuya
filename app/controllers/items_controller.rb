class ItemsController < ApplicationController
  require 'payjp'
  
  def index
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
    
    Payjp.api_key = Rails.application.credentials.PAYJP[:PRIVATE_KEY]

    card = CreditCard.where(user_id: current_user.id).first
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

  private
  def item_params
    params.require(:item).permit(:name, :introduce, :brand, :price, :prefecture_id, :preparation_id, :condition_id,:category_id, :delivery_id, images_attributes: [:url],)
  end  
end

