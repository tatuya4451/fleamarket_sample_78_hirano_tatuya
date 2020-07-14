require 'rails_helper'

describe Address do
  describe '#create_address' do

    it "destination_last_nameが空でない事" do
      address = build(:address, destination_last_name: "")
      address.valid?
      expect(address.errors[:destination_last_name]).to include("を入力してください")
    end

    it "destination_first_nameが空でない事" do
      address = build(:address, destination_first_name: "")
      address.valid?
      expect(address.errors[:destination_first_name]).to include("を入力してください")
    end

    it "destination_last_name_kanaが空でない事" do
      address = build(:address, destination_last_name_kana: "")
      address.valid?
      expect(address.errors[:destination_last_name_kana]).to include("を入力してください")
    end

    it "destination_first_name_kanaが空でない事" do
      address = build(:address, destination_first_name_kana: "")
      address.valid?
      expect(address.errors[:destination_first_name_kana]).to include("を入力してください")
    end

    it "post_codeが空でない事" do
      address = build(:address, post_code: "")
      address.valid?
      expect(address.errors[:post_code]).to include("を入力してください")
    end

    it "post_codeが7文字だった場合" do
      address = build(:address, post_code: "1234567")
      expect(address).to be_valid
    end

    it "prefecture_idが空でない事" do
      address = build(:address, prefecture_id: "")
      address.valid?
      expect(address.errors[:prefecture_id ]).to include("を入力してください")
    end

    it "cityが空でない事" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city ]).to include("を入力してください")
    end

    it "addressが空でない事" do
      address = build(:address, address: "")
      address.valid?
      expect(address.errors[:address]).to include("を入力してください")
    end

    it "お名前（全角）の入力が全角かどうか" do
      address = build(:address, destination_last_name: "sample")
      address.valid?
      expect(address.errors[:destination_last_name]).to include("は不正な値です")
    end

    it "お名前（全角）の入力が全角かどうか" do
      address = build(:address, destination_first_name: "sample")
      address.valid?
      expect(address.errors[:destination_first_name]).to include("は不正な値です")
    end

    it "お名前カナの入力が全角かどうか" do
      address = build(:address, destination_last_name_kana: "さんぷる")
      address.valid?
      expect(address.errors[:destination_last_name_kana]).to include("は不正な値です")
    end

    it "お名前カナの入力が全角かどうか" do
      address = build(:address, destination_last_name_kana: "さんぷる")
      address.valid?
      expect(address.errors[:destination_last_name_kana]).to include("は不正な値です")
    end
  end
end
