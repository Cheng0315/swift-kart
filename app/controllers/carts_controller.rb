class CartsController < ApplicationController

  def display_cart
    if current_user
      @cart = current_cart.items
    else
      @cart = guest_cart
    end
  end

  def delete_item
    if current_user
      current_cart.items.delete_if {|obj| obj['id'] == params[:id].to_i}
      redirect_to cart_path
    else
      guest_cart.delete_if {|obj| obj['id'] == params[:id].to_i}
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
        redirect_to root_path
      else
        @cart = current_user.carts.last
        session[:cart_id] = @cart.id
        redirect_to root_path
      end
    else
      redirect_to root_path
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
      redirect_to signin_path
    end
  end
end