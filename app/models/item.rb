class Item < ApplicationRecord
  # belongs_to :user
  # belongs_to :category
  # belongs_to :comment
  has_many :item_images
  accepts_nested_attributes_for :item_images, allow_destroy: true
  belongs_to_active_hash :brand
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture
end
