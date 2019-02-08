class CartsController < ApplicationController

  def display_cart
  end

  def delete_item
    current_cart.delete_if {|obj| obj['id'] == params[:id].to_i}
    redirect_to cart_path
  end

  def checkout
    if current_cart && current_user
      current_cart.each_with_index do |item, idx|
        @cart_item = CartItem.create(quantity: params[:quantity][idx])
        @cart = Cart.create()
        @cart.cart_items << @cart_item
        @item = Item.find(item['id'])
        @item.cart_items << @cart_item
        current_user.carts << @cart
        session.delete :cart
        flash[:notice] = "Thank you for shopping with Swift Kart! Your order has been placed and we will send you a notice when your order is shipped!"
        redirect_to root_path and return 
      end
    else
      flash[:notice] = "Please sign in or sign up to place your order"
      redirect_to signin_path
    end
  end
end