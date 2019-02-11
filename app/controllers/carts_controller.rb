class CartsController < ApplicationController

  def display_cart
    if session[:cart_path]
      session.delete :cart_path
    end

    if current_user
      @cart = current_cart.items
    else
      @cart = guest_cart
    end
  end

  def delete_item
    if current_user
      @item = Item.find(params[:id].to_i)
      current_cart.items.delete(@item)
      redirect_to cart_path
    else
      guest_cart.delete_if {|obj| obj["id"] == params[:id].to_i}
      redirect_to cart_path
    end
  end

  def find_or_create_cart
    if current_user
      if current_user.carts.empty? || current_user.carts.last.checkout
        @cart = Cart.new()
        current_user.carts << @cart
        @cart.save
        session[:cart_id] = @cart.id
        redirect_to cart_add_guest_cart_path
      else
        @cart = current_user.carts.last
        session[:cart_id] = @cart.id
        redirect_to cart_add_guest_cart_path
      end
    else
      redirect_to root_path
    end
  end 

  def add_guest_cart
    if !guest_cart.empty?
      guest_cart.each do |guest_item|
        if !current_cart.items.any? {|item| item[:id] == guest_item['id']} && not_seller_item(guest_item)
          @item = Item.find(guest_item['id'])
          @cart_item = CartItem.create()
          current_cart.cart_items << @cart_item
          @item.cart_items << @cart_item
        end
      end
      session.delete :guest_cart
      redirect_to redirect_path(session[:cart_path]) and return 
    else 
      redirect_to redirect_path(session[:cart_path])
    end
  end

  def checkout
    if current_cart && current_user
      current_cart.items.each_with_index do |item, idx|
        cart_item = CartItem.find_by(cart_id: current_cart.id, item_id: item.id)
        cart_item.update(quantity: params[:quantity][idx])
      end
        current_cart.update(checkout: true)
        flash[:notice] = "Thank you for shopping with Swift Kart! Your order has been placed and we will notify you when your order is shipped!"
        redirect_to cart_user_cart_path and return 
    else
      flash[:notice] = "Please sign in or sign up to checkout"
      session[:cart_path] = cart_path
      redirect_to signin_path
    end
  end
end