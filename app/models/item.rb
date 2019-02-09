class Item < ApplicationRecord
  belongs_to :user
  belongs_to :user
  has_many :cart_items
  has_many :carts, through: :cart_items

  def self.search(search_term)
    where("name LIKE ?", "%#{search_term}%") 
  end

  def self.search_with_category(search_term, category_id)
    self.all.select {|item| item.name.include?(search_term) && item.category_id == category_id}
  end
end
