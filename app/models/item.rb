class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :cart_items
  has_many :reviews
  has_many :carts, through: :cart_items
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true

  
  scope :search, -> (search_term) {where("lower(name) LIKE ?", "%#{search_term.downcase}%")}
  
  scope :category_search, -> (category_id) {where("category_id = ?", category_id)}

  def self.search_with_category_id(search_term, category_id) 
    self.category_search(category_id).search(search_term)
  end

end
