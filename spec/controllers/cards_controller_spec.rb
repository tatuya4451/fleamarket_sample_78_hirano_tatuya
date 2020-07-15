require 'rails_helper'

describe CardsController do
  let(:user) { create(:user) }
  let(:credit_card) { create(:credit_card) }

  describe 'GET #index' do

    context 'ログイン時' do
      before do
        login user
      end

      it "カード情報を表示" do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'ログインしていない時' do
      it "トップページを表示" do
        get :index
        expect(response).to redirect_to "http://test.host/items"
      end
    end

  end

  describe 'GET #new' do
    context 'ログイン時' do
      before do
        login user  
      end
        
      it "直接アクセスする時、登録カードの情報を表示" do
        get :new
        expect(response).to redirect_to "http://test.host/cards"
      end
    end
    
    context 'ログインしていない時' do
      it "トップページを表示" do
        get :new
        expect(response).to redirect_to "http://test.host/items"
      end
    end
  end
  context "createアクションにアクセスした時" do
    context 'ログイン時' do
      before do
        login user
        @user = User.first
        allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.prepare_customer_information)
        allow(controller).to receive(:current_user).and_return(@user) 
      end
    
      it "カード情報が正しく保存されるか" do
        post :create, params: {token: "tok_xxxxxxxx", customer_id: "cus_ca9d1d98900ec1f2595aebefd9a6"}
        card = create(:credit_card, user_id: user.id, customer_id: "cus_ca9d1d98900ec1f2595aebefd9a6")
        expect(assigns(:card).customer_id).to eq(card.customer_id)
        # コントローラ(モック含む)を経由して生成したcustomer_id（左）と、テストで生成したcustomer_id（右）が
        # 同じ形で保存されているか確認
        
        #---------------------------------！注意！---------------------------------
        # Payjpモックはハッシュでデータ生成、実際のPayjpはインスタンスでデータ生成のため、
        # このままコードを通すとfailureとなります。
        # このテストを確認するには、一時的にcards_controllerのcreateアクションの
        # 以下を変更する必要があります。
        #  current_user.id => current_user[:id]
        #  customer.id => customer[:id]
        #  customer.default_card => customer[:default_card]
        # ------------------------------------------------------------------------
      end
    end
  end
end
