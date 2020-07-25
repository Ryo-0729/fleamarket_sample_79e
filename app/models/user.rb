class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :lastname, :firstname, :lastname_kana, :firstname_kana, :birth_day, :tel_num, :send_lastname, :send_firstname, :send_lastname_kana, :send_firstname_kana, :post_num, :prefectures, :city, :address, :address_2nd,presence: true
  
  has_many :items, dependent: :destroy
  has_many :sendings, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :comments
end
