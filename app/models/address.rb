class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :destination_last_name, :destination_first_name,:destination_last_name_kana,:destination_first_name_kana,:post_code,:prefecture_id,:city,:address, presence: true
  validates :destination_last_name, :destination_first_name, format:{ with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :destination_last_name_kana,:destination_first_name_kana, format:{ with: /\A([ァ-ン]|ー)+\z/ }
  validates :post_code, format: { with: /\A\d{7}\z/}
end
