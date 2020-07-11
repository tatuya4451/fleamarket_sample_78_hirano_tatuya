class CardsController < ApplicationController
  require 'payjp'
  Payjp.api_key = 'PAYJP_PRIVATE_KEY'
  
  def index
    card = CreditCard.where(user_id: current_user.id).first
    #保管した顧客IDでpayjpから情報取得 ※あとでcurrent_user.idに直す
    customer = Payjp::Customer.retrieve(card.customer_id)
    #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    @default_card_information = customer.cards.retrieve(card.card_id)
  end

  def new
  end

  def pay
    #同時に在庫を更新できないように.with_lockでブロック
    # @item.with_lock do
    # @item = Item.find(params[:id])
    # #支払い情報の作成
    card = CreditCard.where(user_id: current_user.id).first
    #保管した顧客IDでpayjpから情報取得 ※あとでcurrent_user.idに直す
    customer = Payjp::Customer.retrieve(card.customer_id)

    #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    Payjp::Charge.create(
      amount: 50, #支払い金額
      customer: card.customer_id, #支払うユーザのpayjp顧客ID
      currency: 'jpy', #通貨の指定
    )
    
    # redirect_to action: 'purchase-done'
    end
  def


  def create
    customer = Payjp::Customer.create(
      card: params['card_token'],
      metadata: {user_id:current_user.id},
      # あとでcurrent_user.idにする
    )
    
    @card = CreditCard.new(
      user_id: current_user.id,
      customer_id: customer.id,
      card_id: customer.default_card
      # あとでcurrent_user.idにする
    )
    
    if @card.save
      redirect_to new_card_path
    else
      redirect_to action: "create"
    end


    # respond_to do |format|
    #   format.html { reditect_to :new_card_path }
    #   format.json { render json: @card }
    # end
  end

  def destroy
    card = CreditCard.where(user_id: current_user.id).first
    #保管した顧客IDでpayjpから情報取得 ※あとでcurrent_user.idに直す
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.delete
    redirect_to action: "new"
  end

  private
  def _params
    params.require(:todo).permit(:content)
  end
end
