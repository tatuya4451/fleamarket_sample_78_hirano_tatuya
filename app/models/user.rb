class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  validates :nickname, :last_name, :first_name,  :birthday, presence: true
  validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :last_name_kana, :first_name_kana, format:{ with: /\A([ァ-ン]|ー)+\z/ }
  validates :email,  uniqueness: true
  validates :password, confirmation: true,length: { minimum: 7 } 
  has_one :address
  # validates :password, confirmation: true

  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL")}, foreign_key: "saler_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL")}, foreign_key: "saler_id", class_name: "Item"
  has_many :items, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_items, through: :bookmarks, source: :item
  has_one :sns_credential, dependent: :destroy

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    return { user: user, sns: sns }
  end
end
