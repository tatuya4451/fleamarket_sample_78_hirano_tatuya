require 'rails_helper'

describe User do
  describe '#create' do

    it "ニックネームが空でない事" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailが空かどうか" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordか空かどうか" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードが7文字以下の場合登録できないこと" do
      user = build(:user, password: "123456")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "生年月日が空かどうか" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    it "お名前（全角）が空かどうか" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end

    it "お名前カナ（全角）が空かどうか" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it "お名前（全角）の入力が全角かどうか" do
      user = build(:user, last_name: "sample")
      user.valid?
      expect(user.errors[:last_name]).to include("は不正な値です")
    end

    it "お名前（全角）の入力が全角かどうか" do
      user = build(:user, first_name: "sample")
      user.valid?
      expect(user.errors[:first_name]).to include("は不正な値です")
    end

    it "お名前カナ（全角）の入力が全角かどうか" do
      user = build(:user, first_name_kana: "さんぷる")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は不正な値です")
    end

    it "お名前カナ（全角）の入力が全角かどうか" do
      user = build(:user, last_name_kana: "さんぷる")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("は不正な値です")
    end

    end
  end