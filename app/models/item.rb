class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to :item
  belongs_to :comment
  has_many :item_images
  accepts_nested_attributes_for :item_images, allow_destroy: true
end
