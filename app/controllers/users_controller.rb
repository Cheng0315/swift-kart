class UsersController < ApplicationController 

  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save 
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_user_path
    end
  end



  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :seller)
  end
end