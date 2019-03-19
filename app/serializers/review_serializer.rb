class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :item_id, :rating, :comment, :created_at, :total_reviews
  belongs_to :user

  def total_reviews
    Review.all.count
  end
end
