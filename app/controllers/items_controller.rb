class ItemsController < ApplicationController 

  def new
    @item = Item.new(user_id: params[:user_id])
    @user = current_user
  end

end