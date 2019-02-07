class ItemsController < ApplicationController 

  def new
    @item = Item.new(user_id: params[:user_id])
    @user = current_user
  end

  def create
    
  end

  private

  def items_params
    params.require(:item).permit(:name, :price, :description, :user_id)
  end
end