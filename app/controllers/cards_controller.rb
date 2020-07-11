class CardsController < ApplicationController
  require 'payjp'
  Payjp.api_key = Rails.application.credentials.PAYJP[:PRIVATE_KEY]
  
  def index
    card = CreditCard.where(user_id: current_user.id).first
    #保管した顧客IDでpayjpから情報取得
    customer = Payjp::Customer.retrieve(card.customer_id)
    #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
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

  def new
  end

  def pay
    # 支払い情報の作成
    card = CreditCard.where(user_id: current_user.id).first
    #保管した顧客IDでpayjpから情報取得
    customer = Payjp::Customer.retrieve(card.customer_id)
    #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    Payjp::Charge.create(
      amount: 50, #支払い金額
      customer: card.customer_id, #支払うユーザのpayjp顧客ID
      currency: 'jpy', #通貨の指定
    )       
    redirect_to purchase_done_items_path
 
  end

  def create
    customer = Payjp::Customer.create(
      card: params['card_token'],
      metadata: {user_id:current_user.id},
    )
    
    @card = CreditCard.new(
      user_id: current_user.id,
      customer_id: customer.id,
      card_id: customer.default_card
    )
    
    if @card.save
      redirect_to new_card_path
    else
      redirect_to action: "create"
    end

  end

  def destroy
    card = CreditCard.where(user_id: current_user.id).first
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.delete
    redirect_to action: "new"
  end

end
