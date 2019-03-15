class ReviewsController < ApplicationController 

  def new
    if current_user && params[:id]
      @item = Item.find(params[:id])
      @review = Review.new
    else
      redirect_to root_path
    end
  end

  def create 
    if current_user
      @review = Review.new(reviews_params)
      @review.user_id = current_user.id
      @review.item_id = params[:item_id]

      if @review.save
        redirect_to review_path(@review)
      else
        render :new
      end
    else
      redirect_to root_path
    end

  end

  def show 
    @review = Review.find(params[:id])
  end


  private

  def reviews_params
    params.require(:review).permit(:user_id, :item_id, :rating, :comment)
  end
end