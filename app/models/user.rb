class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # has_many :items, dependent: :destroy
  has_many :sendings, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :comments

  validates :nickname, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birthyear, presence: true
  validates :birthmonth, presence: true
  validates :birthday, presence: true
  validates :post_first_name, presence: true
  validates :post_last_name, presence: true
  validates :post_first_name_kana, presence: true
  validates :post_last_name_kana, presence: true
  validates :post_cord, presence: true
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :building, presence: true
  validates :telephone, presence: true
end
