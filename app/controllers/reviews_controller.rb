class ReviewsController < ApplicationController 
  
  def new
    @review = Review.new
  end


  private

  def reviewss_params
    params.require(:review).permit(:user_id, :item_id)
  end
end