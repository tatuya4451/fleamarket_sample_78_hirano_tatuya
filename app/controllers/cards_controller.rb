class CardsController < ApplicationController
  require 'payjp'
  Payjp.api_key = Rails.application.credentials.PAYJP[:PRIVATE_KEY]

  def pay
    # 支払い情報の作成
    card = CreditCard.find_by(user_id: current_user.id)
    #保管した顧客IDでpayjpから情報取得
    customer = Payjp::Customer.retrieve(card.customer_id)
    #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    Payjp::Charge.create(
      amount: 50, #支払い金額
      customer: card.customer_id, #支払うユーザのpayjp顧客ID
      currency: 'jpy', #通貨の指定
    )

    @item_buyer = Item.find(3)
    # あとでparams[:id]にする
    @item_buyer.update( buyer_id: current_user.id)

    redirect_to purchase_done_items_path
 
  end

end
