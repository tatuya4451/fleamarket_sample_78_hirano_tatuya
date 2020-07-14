require 'rails_helper'

describe CardsController do
  describe 'GET #index' do
    it "登録カードの情報を表示" do
      context 'ログイン時' do
        before do
          login user
        end
      
      
    end

    it "ログインしていない時、トップページを表示" do
    end
  end

  describe 'GET #new' do
    it "直接アクセスする時、登録カードの情報を表示" do
    end

    it "すでにカードが登録されている時、登録カードの情報を表示" do
    end

    it "ログインしていない時、トップページを表示" do
    end
  end

  describe 'post #create' do
    it "カード番号が不正の時、保存されない" do
    end

    it "カード期限が過去の時、保存されない" do
    end

    it "セキュリティ番号が不正な時、保存されない" do
    end

    it "登録完了後、登録画面の直線にいた画面に戻る" do
    end
  end

end