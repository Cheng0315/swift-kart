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

  def check_if_item_exists_in_user_cart(item, params_path)
    if user_cart_is_empty
      add_item_to_user_cart(item, params_path)
    else
      if item_exists_in_user_cart(item)
        flash[:notice] = 'Item already exists in your cart. Please select the quantity you like in the quantity section when checkout.'
        redirect_to redirect_path(params_path)
      else
        add_item_to_user_cart(item, params_path)
      end
    end
  end

  def item_exists_in_user_cart(item)
    current_cart.items.any? {|cartitem| cartitem['id'] == item.id}
  end

  def user_cart_is_empty
    current_cart.items.empty?
  end

  def add_item_to_user_cart(item, params_path)
    @cart_item = CartItem.create()
    current_cart.cart_items << @cart_item
    item.cart_items << @cart_item
    flash[:notice] = 'Successfully added item to cart'
    redirect_to redirect_path(params_path)
  end

  def update_quantity_of_item_in_cart
    current_cart.items.each_with_index do |item, idx|
      cart_item = CartItem.find_by(cart_id: current_cart.id, item_id: item.id)
      cart_item.update(quantity: params[:quantity][idx])
    end
  end

  def redirect_path(path)
    if path
      path
    else
      root_path
    end
  end
end
