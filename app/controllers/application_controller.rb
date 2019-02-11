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

  def delete_item_in_guest_cart(item_id)
    guest_cart.delete_if {|item| item["id"] == item_id}
  end

  def redirect_path(path)
    if path
      path
    else
      root_path
    end
  end
end
