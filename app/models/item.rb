class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  # belongs_to :comment
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation

  validates :item_images, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :text, presence: true, length: { maximum: 1000 }
  validates :category, presence: true
  validates :condition_id, presence: true
  validates :postage_payer_id, presence: true
  validates :prefecture_id, presence: true
  validates :preparation_id, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}

  def self.search(search)
    if search
      Item.where('items.name LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

end
