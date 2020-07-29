class Item < ApplicationRecord
  # belongs_to :user
  # belongs_to :category
  # belongs_to :brand
  # belongs_to :comment
  has_many :item_images
  accepts_nested_attributes_for :item_images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
