class ItemsController < ApplicationController 

  def index
    if params[:search]
      @items = search_items(params[:search], params[:category])
    else
      @items = Items.all
    end
  end

  def my_items
    if current_user && current_user.seller
      @items = current_user.items
      @view_my_items = true 
      render :index
    else
      redirect_to root_path
    end
  end

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

    if current_user
      check_if_item_exists_in_cart(current_cart, @item, params[:redirect_to])
    else
      check_if_item_exists_in_cart(guest_cart, @item, params[:redirect_to])
    end
  end

  def create
    if current_user && current_user.seller
      create_item
    else
      redirect_to root_path
    end
  end

  def show
    @item = Item.find_by(id: params[:id])
 
    if @item.nil? 
      flash[:notice] = "unable to find the item you're looking for"
      redirect_to root_path
    else 
      @item
    end 
  end

  def my_orders
    if current_user
      @carts = current_user.carts
    else
      redirect_to root_path
    end
  end

  def buyer_orders 
    if current_user && current_user.seller
      @items = find_buyers_orders
    else
      redirect_to signin_path
    end
  end

  def ship_items
    if current_user && current_user.seller
      @cart_item = CartItem.find_by(cart_id: params[:cart_id], item_id: params[:item_id])
      @cart_item.update(shipped: true)
      redirect_to buyer_orders_path
    else
      redirec_to root_path
    end
  end

  def edit 
    @item = Item.find(params[:id])
    if current_user
      check_if_item_belongs_to_user(@item)
    else
      redirect_to item_path(@item)
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.user.id == current_user.id && @item.update(items_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])

    if @item.user.id == current_user.id
      @item.destroy
      redirect_to root_path
    else
      redirect_to item_path(@item)
    end
  end


  private

  def items_params
    params.require(:item).permit(:name, :price, :description, :category_id, :search, :in_stock, :image, :shipped)
  end

  
end