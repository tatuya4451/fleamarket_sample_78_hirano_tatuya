class Image < ApplicationRecord
  mount_uploader :url, ImageUploader
  belongs_to :item
  validates :url, presence: true
end
