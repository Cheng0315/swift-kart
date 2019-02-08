class ItemsController < ApplicationController 

  def new
    if current_user
      if current_user.seller
        @item = Item.new
      else
        redirect_to root_path
      end
    else
      redirect_to signin_path
    end
  end

  def add_to_cart
    @item = Item.find(params[:id].to_i)
    
    if !current_cart.empty?
      if current_cart.any? {|item| item['id'] == params[:id].to_i}
        flash[:notice] = 'Item already exists in cart. You may select the quantity you like in the quantity section on checkout.'
        redirect_to root_path
      else
        current_cart << @item
        flash[:notice] = 'Successfully added item to cart'
        redirect_to root_path
      end
    else
      current_cart << @item
      flash[:notice] = 'Successfully added item to cart'
      redirect_to root_path
    end
  end

  def create
    @item = Item.new(new_items_params)
   
    if current_user.seller
      @item.seller_id = current_user.id
      @item.save
      redirect_to user_item_path(current_user, @item)
    else
      render :new
    end
  end

  def show
    @item = Item.find_by(id: params[:id])
    binding.pry
      if @item.nil? 
        flash[:notice] = "unable to find the item you're looking for"
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

    if @item.seller_id == current_user.id
      @item.destroy
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