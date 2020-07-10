class Item < ApplicationRecord
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
  end
  validates_associated :images
  validates :images, presence: true
end
