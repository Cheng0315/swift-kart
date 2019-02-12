class ApplicationController < ActionController::Base

  helper_method :current_user, :current_cart, :guest_cart, :not_seller_item
  

  def current_cart
    @current_cart ||= Cart.find(session[:cart_id]) if session[:cart_id]
  end

  def guest_cart
    session[:guest_cart] ||= []
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def not_seller_item(item)
    @seller = User.find(item['user_id'])
    @seller.id != current_user.id
  end

  private

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
    guest_cart.each do |guest_item|
      if guest_item_does_not_exist_in_user_cart(guest_item)
        @item = Item.find(guest_item['id'])
        @cart_item = CartItem.create()
        current_cart.cart_items << @cart_item
        @item.cart_items << @cart_item
      end
    end
  end

  def guest_item_does_not_exist_in_user_cart(guest_item)
    !current_cart.items.any? {|item| item[:id] == guest_item['id']} && not_seller_item(guest_item)
  end

  def delete_item_in_guest_cart(item_id)
    guest_cart.delete_if {|item| item["id"] == item_id}
  end

  def search_items(search_term, category)
    if category[:id].blank?
      @items = Item.search(search_term)
    else
      @items = Item.search_with_category(search_term, category[:id].to_i)
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
      flash[:notice] = 'Item already exists in your cart. Please select the quantity you like in the quantity section when checkout.'
      redirect_to redirect_path(params_path)
    else
      add_item_to_cart(cart, item, params_path)
    end
  end

  def item_exists_in_cart(cart, item)
    if cart.class == Array
      cart.any? {|cart_item| cart_item['id'] == item.id}
    else
      cart.items.any? {|cart_item| cart_item['id'] == item.id}
    end
  end

  def add_item_to_cart(cart, item, params_path)
    if current_user
      @cart_item = CartItem.create()
      cart.cart_items << @cart_item
      item.cart_items << @cart_item
      flash[:notice] = 'Successfully added item to cart'
      redirect_to redirect_path(params_path)
    else
      cart << item
      flash[:notice] = 'Successfully added item to cart'
      redirect_to redirect_path(params_path)
    end
  end

  def update_quantity_of_item_in_cart
    current_cart.items.each_with_index do |item, idx|
      cart_item = CartItem.find_by(cart_id: current_cart.id, item_id: item.id)
      cart_item.update(quantity: params[:quantity][idx])
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

  def redirect_path(path)
    if path
      path
    else
      root_path
    end
  end
end
