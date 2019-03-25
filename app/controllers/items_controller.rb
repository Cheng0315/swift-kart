class ItemsController < ApplicationController 

  #take user's input from the search form and find items that has a name that include the user's input
  def index
    @search_term = params[:search]
    @category = Category.find(params[:category][:id]) if !params[:category][:id].empty?

    if params[:search]
      @items = search_items(params[:search], params[:category])
    else
      @items = current_user.items.all
    end
  end

  #find all items created by the user
  def my_items
    if current_user && current_user.seller
      @items = current_user.items
      @view_my_items = true 
      render :index
    else
      redirect_to root_path
    end
  end
 
  #create new item
  def new
    if current_user
      if params[:user_id] && params[:user_id].to_i == current_user.id
        @user = User.find(params[:user_id].to_i)
        if @user.seller
          @item = Item.new
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    else
      redirect_to signin_path
    end
  end

  #save item to the database
  def create
    if current_user && current_user.seller
      create_item
    else
      redirect_to root_path
    end
  end

  #add item to cart 
  def add_to_cart
    @item = Item.find(params[:id].to_i)

    if current_user
      check_if_item_exists_in_cart(current_cart, @item, params[:redirect_to])
      @items_count = current_cart.items.count
    else
      check_if_item_exists_in_cart(guest_cart, @item, params[:redirect_to])
      @items_count = guest_cart.count
    end
    
    render plain: @items_count
  end

  #find item and render item show page
  def show
    @item = Item.find_by(id: params[:id])
    @latest_products = Item.last(3).reverse
    
    if !@item.nil?
      @reviews = @item.reviews
      @new_review = Review.new
      if params[:user_id] && params[:user_id].to_i != current_user.id
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  #sort reviews based on the user's selection
  def sort_reviews
    @item = Item.find(params[:itemId])
    
    if params[:sortBy] == 'oldest'
      @reviews = @item.reviews.sort { |a,b| a.created_at <=> b.created_at }
      render json: @reviews
    elsif params[:sortBy] == 'most_recent'
      @reviews = @item.reviews.sort { |a,b| b.created_at <=> a.created_at }
      render json: @reviews
    elsif params[:sortBy] == 'highest_rating'
      @reviews = @item.reviews.sort { |a,b| b.rating <=> a.rating }
      render json: @reviews
    elsif params[:sortBy] == 'lowest_rating'
      @reviews = @item.reviews.sort { |a,b| a.rating <=> b.rating }
      render json: @reviews
    end
  end

  #find items ordered by the user
  def my_orders
    if current_user
      @carts = current_user.carts
    else
      redirect_to root_path
    end
  end

  #find items ordered by buyer
  def buyer_orders 
    if current_user && current_user.seller
      @items_info = find_buyers_orders.sort_by { |k| item_is_shipped(k[3],k[0].id) ? 1 : 0 }
    else
      redirect_to signin_path
    end
  end

  #update status of items to 'shipped'
  def ship_items
    if current_user && current_user.seller
      @cart_item = CartItem.find_by(cart_id: params[:cart_id], item_id: params[:item_id])
      @cart_item.update(shipped: true)
      redirect_to buyer_orders_path
    else
      redirec_to root_path
    end
  end

  #find and edit item
  def edit 
    @item = Item.find_by(id: params[:id])
  
    if current_user
      check_if_item_belongs_to_user(@item)
    else
      redirect_to root_path
    end
  end

  #update item in database
  def update
    @item = Item.find(params[:id])

    if @item.user.id == current_user.id && @item.update(items_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  #delete item in database
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
    params.require(:item).permit(:name, :price, :description, :category_id, :condition, :search, :in_stock, :image, :shipped)
  end

  
end