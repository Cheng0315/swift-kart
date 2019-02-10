class ItemsController < ApplicationController 

  def index
    if params[:search]
      if params[:category][:id].blank?
        @items = Item.search(params[:search])
      else
        @items = Item.search_with_category(params[:search], params[:category][:id].to_i)
      end
    else
      redirect_to root_path
    end
  end

  def my_items
    if current_user && current_user.seller
      @items = current_user.items
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
    if !current_user
      if !guest_cart.empty?
        if guest_cart.any? {|item| item['id'] == params[:id].to_i}
          flash[:notice] = 'Item already exists in cart. You may select the quantity you like in the quantity section when checkout.'
          redirect_to root_path
        else
          guest_cart << @item
          flash[:notice] = 'Successfully added item to cart'
          redirect_to root_path
        end
      else
        guest_cart << @item
        flash[:notice] = 'Successfully added item to cart'
        redirect_to root_path
      end
    else
      if !current_cart.items.empty?
        if current_cart.items.any? {|item| item['id'] == params[:id].to_i}
          flash[:notice] = 'Item already exists in cart. You may select the quantity you like in the quantity section when checkout.'
          redirect_to this_path(params[:redirect_to])
        else
          @cart_item = CartItem.create()
          current_cart.cart_items << @cart_item
          @item.cart_items << @cart_item
          flash[:notice] = 'Successfully added item to cart'
          redirect_to this_path(params[:redirect_to])
        end
      else
        @cart_item = CartItem.create()
        current_cart.cart_items << @cart_item
        @item.cart_items << @cart_item
        flash[:notice] = 'Successfully added item to cart'
        redirect_to this_path(params[:redirect_to])
      end
    end
  end

  def create

    if current_user.seller
      @item = Item.new(items_params)
      @item.user_id = current_user.id
      if @item.save
        @category = Category.find(items_params[:category_id])
        @category.items << @item
        current_user.items << @item
        @item.save
        redirect_to user_item_path(current_user, @item)
      else
        render :new
      end
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

  def orders
    if current_user
      @carts = current_user.carts
    else
      redirect_to root_path
    end
  end

  def edit 
    @item = Item.find(params[:id])
    if @item.user.id == current_user.id
      render :edit
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
    params.require(:item).permit(:name, :price, :description, :category_id, :search, :in_stock)
  end

  
end