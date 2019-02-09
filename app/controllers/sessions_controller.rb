class SessionsController < ApplicationController 

  def new
    if current_user
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to cart_user_cart_path
    else
      redirect_to signin_path
    end
  end

  def logout
    session.delete :user_id
    session.delete :cart_id
    redirect_to root_path
  end
end