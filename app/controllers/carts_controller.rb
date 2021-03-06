class CartsController < ApplicationController
  #display all items in the cart
  def display_cart
    if session[:cart_path]
      session.delete :cart_path
    end

    if current_user
      @cart = current_cart.items
    else
      @cart = find_all_items_in_guest_cart
    end
  end

  #delete an item in the cart
  def delete_item
    if current_user
      @item = Item.find(params[:id].to_i)
      current_cart.items.delete(@item)
      redirect_to cart_path
    else
      delete_item_in_guest_cart(params[:id].to_i)
      redirect_to cart_path
    end
  end

  #find or create a new cart for the user
  def find_or_create_cart
    if current_user
      find_or_create_new_cart_for_user
      redirect_to cart_add_guest_cart_path
    else
      redirect_to root_path
    end
  end 

  #add items in guest's cart to user's cart
  def add_guest_cart
    if !guest_cart.empty?
      add_guest_items_to_user_cart
      session.delete :guest_cart
      redirect_to redirect_path(session[:cart_path]) and return 
    else 
      redirect_to redirect_path(session[:cart_path])
    end
  end

  #checkout and update user's cart
  def checkout
    if current_cart && current_user
      update_quantity_of_item_in_cart
      current_cart.update(total_price: params[:total_price], checkout: true)
      flash[:notice] = success_checkout_message
      redirect_to cart_user_cart_path and return 
    else
      flash[:notice] = "Please sign in or sign up to checkout"
      session[:cart_path] = cart_path
      redirect_to signin_path
    end
  end
end