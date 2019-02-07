class ItemsController < ApplicationController 

  def new
    if current_user.seller
      @item = Item.new
    else
      redirect_to root_path
    end
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
    @item = Item.find_by(id: params[:id])
  
      if @item.nil? 
        flash[:notice] = "the item you're looking for doesn't exists"
        redirect_to root_path
      else 
        @item
      end
      
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