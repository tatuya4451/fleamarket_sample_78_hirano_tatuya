class Item < ApplicationRecord
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  has_many :images
  belongs_to :category
  belongs_to :delivery
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :preparation

  with_options presence: true do
    validates :name
    validates :introduce
    validates :condition_id
    validates :prefecture_id
    validates :preparation_id
    validates :price
    validates :saler_id
    validates :category_id
    validates :delivery_id
  end
  validates_associated :images
  validates :images, presence: true

  def self.search(search)
      if search
        Item.where('name LIKE(?)', "%#{search}%")
      else
        Item.all  
      end
  end

  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
  
  enum trading_status: { exhibiting: 0, duringTrading: 1, transacted: 2 }

    ransacker :bookmarks_count do
      query = '(SELECT COUNT(bookmarks.item_id) FROM bookmarks where bookmarks.item_id = items.id GROUP BY bookmarks.item_id)'
      Arel.sql(query)
    end
end
