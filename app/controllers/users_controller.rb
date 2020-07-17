class UsersController < ApplicationController
  require 'payjp'
  before_action :set_item_search_query
  Payjp.api_key = Rails.application.credentials.PAYJP[:PRIVATE_KEY]

  def show
    @parents = Category.where(ancestry: nil)
  end

  def logout
    @parents = Category.where(ancestry: nil)
  end
  
  def cardindex
    @parents = Category.where(ancestry: nil)

    if user_signed_in?
      # インデックスの直前のページ情報を取得
      @@previous_page = request.referrer
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
    else
      redirect_to items_path
    end
  end

  def cardnew
    if user_signed_in?
      # 直打ちでcards/newに移動できないようにする（直打ちはrequest.referrer = nil）
      previous_page2 = request.referrer
      if previous_page2.blank?
        redirect_to cardindex_users_path
      end
    else
      redirect_to items_path
    end
  end

  def cardcreate
    customer = Payjp::Customer.create(
      card: params['card_token'],
      metadata: {user_id: current_user.id},
    )
    @card = CreditCard.new(
      user_id: current_user.id,
      customer_id: customer.id,
      card_id: customer.default_card
    )

    # カード登録の直前にいたページ（商品購入画面orマイページ）に戻る
    if @@previous_page.blank?
      redirect_to cardindex_users_path
    else
      @card.save ? (redirect_to @@previous_page) : (redirect_to cardindex_users_path)
    end

  end

  def destroy
    card = CreditCard.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.delete
    redirect_to cardnew_users_path
  end

end
