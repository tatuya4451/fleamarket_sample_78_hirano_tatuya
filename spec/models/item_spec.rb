require 'rails_helper'

describe Item do
  describe '#create' do
    context 'can save' do
      it "全て入力していると保存できること" do
        user = create(:user)
        expect(build(:item, saler_id: user[:id])).to be_valid
      end
    end


    context 'can not save' do
      
      it "商品名が空の場合保存できないこと" do
        item = build(:item, name: nil)
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end

      it "商品の説明が空の場合保存できないこと" do
        item = build(:item, introduce: nil)
        item.valid?
        expect(item.errors[:introduce]).to include("を入力してください")
      end

      it "カテゴリーが選択されていないと保存できないこと" do
        item = build(:item, category: nil)
        item.valid?
        expect(item.errors[:category]).to include("を入力してください")
      end

      it "商品の状態が空の場合保存できないこと" do
        item = build(:item, condition_id: nil)
        item.valid?
        expect(item.errors[:condition_id]).to include("を入力してください")
      end

      it "配送料の負担が空の場合保存できないこと" do
        item = build(:item, delivery: nil)
        item.valid?
        expect(item.errors[:delivery]).to include("を入力してください")
      end

      it "発送元の地域が空の場合保存できないこと" do
        item = build(:item, prefecture_id: nil)
        item.valid?
        expect(item.errors[:prefecture_id]).to include("を入力してください")
      end
      it "発送までの日数が空の場合保存できないこと" do
        item = build(:item, preparation_id: nil)
        item.valid?
        expect(item.errors[:preparation_id]).to include("を入力してください")
      end  

      it "販売価格が空の場合保存できないこと" do
        item = build(:item, price: nil)
        item.valid?
        expect(item.errors[:price]).to include("を入力してください")
      end 

      it "売り手の情報が空の場合保存できないこと" do
        item = build(:item, saler: nil)
        item.valid?
        expect(item.errors[:saler]).to include("を入力してください")
      end 
    end
  end
end