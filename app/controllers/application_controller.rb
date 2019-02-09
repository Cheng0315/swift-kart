class ApplicationController < ActionController::Base

  helper_method :current_user, :current_cart
  
  def current_cart
    session[:cart] ||= []
  end

  def guest_cart
    session[:guest_cart] ||= []
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
