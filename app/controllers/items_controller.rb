class ItemsController < ApplicationController 

  def new
    @item = Item.new(user_id: params[:user_id])
    @user = current_user
  end

  def create
    @item = Item.new(items_params)

    if @item.save
      redirect_to item_path
    else
      render :new
    end
  end

  private

  def items_params
    params.require(:item).permit(:name, :price, :description, :user_id)
  end
end