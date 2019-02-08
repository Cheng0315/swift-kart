class User < ApplicationRecord
  has_many :carts
  has_many :items
  has_secure_password
end
