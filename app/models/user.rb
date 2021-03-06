class User < ApplicationRecord
  has_many :carts
  has_many :items
  has_many :reviews, dependent: :destroy
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  
end
