class SessionsController < ApplicationController 

  def new
    if current_user
      redirect_to root_path
    end
  end

  def create
    if params[:email] || params[:password]
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to cart_user_cart_path
      else
        flash[:notice] = "Invalid email or password"
        redirect_to signin_path
      end
    else
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.first_name = auth['info']['name'].split[0]
        u.last_name = auth['info']['name'].split[1] 
        u.email = auth['info']['email']
        u.password = auth['info']['email']
        u.seller = false
      end
      session[:user_id] = @user.id
      redirect_to cart_user_cart_path
    end
  end

  def logout
    session.delete :user_id
    session.delete :cart_id
    redirect_to root_path
  end

  
  private

  def auth
    request.env['omniauth.auth']
  end
end