class Item < ApplicationRecord
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  has_many :images,dependent: :destroy
  belongs_to :category
  belongs_to :delivery
  accepts_nested_attributes_for :images, allow_destroy: true, update_only: true, reject_if: :no_image
  def no_image(image_attributes)
    image_attributes[:url].blank?
  end
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
  
  enum trading_status: { exhibiting: 0, duringTrading: 1, transacted: 2 }

end
