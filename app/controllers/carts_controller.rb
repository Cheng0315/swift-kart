class CartsController < ApplicationController

  def display_cart
  end

  def delete_item
    current_cart.delete_if {|obj| obj['id'] == params[:id].to_i}
    redirect_to cart_path
  end
end