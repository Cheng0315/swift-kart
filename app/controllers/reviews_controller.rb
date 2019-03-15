class ReviewsController < ApplicationController 

  def new
    if current_user && params[:item_id] && current_user_bought_the_item(params[:item_id])
      @review = Review.new
    else
      redirect_to root_path
    end
  end

  def create 
    if current_user
      @review = Review.new(reviews_params)
      @item = Item.find(params[:item_id])
      @review.user_id = current_user.id
      @review.item_id = @item.id

      if @review.save
        redirect_to item_path(@item)
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