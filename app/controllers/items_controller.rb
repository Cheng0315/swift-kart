class ItemsController < ApplicationController 

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(new_items_params)
   
    if current_user.seller
      @item.seller_id = current_user.id
      binding.pry
      @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit 
    @item = Item.find(params[:id])
    if @item.seller_id == current_user.id
      render :edit
    else
      redirect_to item_path(@item)
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.seller_id == current_user.id
      @item.update(update_items_params)
      redirect_to item_path(@item)
    else
      redirect_to item_path(@item)
    end
  end

  def destroy
    @item = Item.find(params[:id])
    binding.pry
    if @item.seller_id = current_user.id
      @item.destroy
      binding.pry
      redirect_to root_path
    else
      redirect_to item_path(@item)
    end
  end


  private

  def new_items_params
    params.require(:item).permit(:name, :price, :description, :seller_id)
  end

  def update_items_params
    params.require(:item).permit(:name, :price, :description)
  end
end