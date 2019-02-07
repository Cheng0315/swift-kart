class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :cart_items
  has_many :carts, through: :cart_items
end
