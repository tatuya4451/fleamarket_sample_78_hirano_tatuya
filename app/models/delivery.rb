class Delivery < ApplicationRecord
  has_ancestry
  has_many :items
end
