class ApplicationController < ActionController::Base

  helper_method :current_user, :current_cart, :guest_cart, :not_seller_item, :item_is_shipped, :current_user_bought_the_item
  
  def current_cart
    @current_cart ||= Cart.find(session[:cart_id]) if session[:cart_id]
  end

  def guest_cart
    session[:guest_cart] ||= []
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def not_seller_item(item_id)
    @item = Item.find(item_id)
    @item.user.id != current_user.id
  end

  
  
  private

  #Helper methods related to cart
  def find_or_create_new_cart_for_user
    if current_user.carts.empty? || current_user.carts.last.checkout
      create_new_cart_for_user
    else
      @cart = current_user.carts.last
      session[:cart_id] = @cart.id
    end
  end

  def create_new_cart_for_user
    @cart = Cart.new()
    current_user.carts << @cart
    @cart.save
    session[:cart_id] = @cart.id
  end

  def add_guest_items_to_user_cart
    guest_cart.each do |item_id|
      if guest_item_does_not_exist_in_user_cart(item_id)
        @item = Item.find(item_id)
        @cart_item = CartItem.create()
        current_cart.cart_items << @cart_item
        @item.cart_items << @cart_item
      end
    end
  end

  def guest_item_does_not_exist_in_user_cart(item_id)
    !current_cart.items.any? {|item| item[:id] == item_id} && not_seller_item(item_id)
  end

  def delete_item_in_guest_cart(item_id)
    guest_cart.delete_if {|id| id == item_id}
  end

  #Helper methods related to displaying messages
  def display_item_exist_in_cart_msg
    "<div class='alert alert-warning alert-dismissible fade show add-item-msg'>
      <button type='button' class='close' data-dismiss='alert'>&times;</button>
      <span class='text-center'>Item already exists in your cart. Please select the quantity you like in the quantity section on checkout.</span>
    </div>".html_safe
  end

  def add_item_to_cart(cart, item, params_path)
    if current_user
      @cart_item = CartItem.create()
      cart.cart_items << @cart_item
      item.cart_items << @cart_item
      flash[:notice] = display_add_to_cart_msg
      redirect_to redirect_path(params_path)
    else
      cart << item.id
      flash[:notice] = display_add_to_cart_msg
      redirect_to redirect_path(params_path)
    end
  end

  def display_add_to_cart_msg
    "<div class='alert alert-success alert-dismissible fade show add-item-msg'>
      <button type='button' class='close' data-dismiss='alert'>&times;</button>
      <span class='text-center'>Successfully added item to cart.</span>
    </div>".html_safe
  end

  def display_review_msg
    "<div class='alert alert-warning alert-dismissible fade show add-item-msg'>
      <button type='button' class='close' data-dismiss='alert'>&times;</button>
      <span class='text-center'>Please buy the item before you can write a review about the item</span>
    </div>".html_safe
  end

  def success_checkout_message
    "<div class='alert alert-success alert-dismissible fade show add-item-msg'>
      <button type='button' class='close' data-dismiss='alert'>&times;</button>
      <span class='text-center'>Thank you for shopping with Swift Kart! Your order has been placed and we will notify you when your order is shipped!</span>
    </div>".html_safe
  end

  #Helper methods related to items
  def search_items(search_term, category)
    if category[:id].blank?
      @items = Item.search(search_term)
    else
      @items = Item.search_items(search_term, category[:id].to_i)
    end
  end

  def create_item
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
  end

  def check_if_item_exists_in_cart(cart, item, params_path)
    if item_exists_in_cart(cart, item)
      flash[:notice] = display_item_exist_in_cart_msg
      redirect_to redirect_path(params_path)
    else
      add_item_to_cart(cart, item, params_path)
    end
  end

  def item_exists_in_cart(cart, item)
    if cart.class == Array
      cart.any? {|id| id == item.id}
    else
      cart.items.any? {|cart_item| cart_item['id'] == item.id}
    end
  end

  def find_all_items_in_guest_cart
    items = []

    guest_cart.each do |id|
      item = Item.find(id)
      items << item
    end

    items
  end

  def find_buyers_orders
    @items = current_user.items
    
    @buyers_items_info = find_buyers_items(@items)
    @buyers_items_info
  end

  def find_buyers_items(items)
    arr_of_items_info = []

    items.each do |item|
      @carts = item.carts.select{|cart| cart.checkout == true}
      
      if !@carts.empty?
        @carts.each do |cart|
          @buyer_id = cart.user_id
          @quantity = find_quantity(cart, item)
          arr_of_items_info << [item, @buyer_id, @quantity, cart.id] 
        end
      end
    end
    
    arr_of_items_info
  end

  def find_quantity(cart, item)
    CartItem.find_by(cart_id: cart.id, item_id: item.id).quantity
  end

  def item_is_shipped(cart_id, item_id)
    CartItem.find_by(cart_id: cart_id, item_id: item_id).shipped
  end

  def update_quantity_of_item_in_cart
    current_cart.items.each_with_index do |item, idx|
      cart_item = CartItem.find_by(cart_id: current_cart.id, item_id: item.id)
      cart_item.update(quantity: params[:quantity][idx])
    end
  end

  def check_if_item_belongs_to_user(item)
    if item.nil?
      redirect_to root_path
    else
      if item.user_id == current_user.id
        render :edit
      else
        redirect_to root_path
      end
    end
  end

  #Helper methods related to users
  def update_user_info
    @user = current_user
    if @user.update(users_params)
      redirect_to user_path(@user)
    else  
      render :edit
    end
  end

  def signin_with_signin_form
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to cart_user_cart_path
    else
      flash[:notice] = "Invalid email or password"
      redirect_to signin_path
    end
  end

  def signin_with_facebook
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.first_name = auth['info']['name'].split[0]
      u.last_name = auth['info']['name'].split[1] 
      u.email = auth['info']['email']
      u.password = auth['info']['email']
      u.seller = false
    end
    session[:user_id] = @user.id
    redirect_to cart_user_cart_path
  end

  def current_user_bought_the_item(item_id)
    @item = Item.find(item_id)
    current_user.carts.each do |cart|
      return true if cart.items.include?(@item)
    end

    false
  end

  def todays_deal
    Item.all.select {|item| item.id == 6 || item.id == 15 || item.id == 16 }
  end

  def trending_items
    Item.all.select {|item| item.id == 8 || item.id == 21 || item.id == 25 }
  end

  def recommended_items
    Item.all.select {|item| item.id == 3 || item.id == 10 || item.id == 17 }
  end

  def featured_items
    Item.all.select {|item| item.id == 4 || item.id == 11 || item.id == 18 }
  end

  def redirect_path(path)
    if path
      path
    else
      root_path
    end
  end
end
