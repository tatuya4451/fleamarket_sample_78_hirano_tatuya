class Item < ApplicationRecord
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  has_many :images
  belongs_to :category
  belongs_to :delivery
  accepts_nested_attributes_for :images, allow_destroy: true
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
    return Item.all unless search
      Item.where('name LILE(?)', "%#{search}")
  end
  
end
