class CartsController < ApplicationController

  def index
    @cart = session[:cart]
  end
end