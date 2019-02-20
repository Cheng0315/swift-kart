class SessionsController < ApplicationController 
  
  def new
    if current_user
      redirect_to root_path
    end
    render :layout => 'signin_signup'
  end

  def create
    if params[:email] 
      signin_with_signin_form
    else
      signin_with_facebook
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