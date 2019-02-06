class UsersController < ApplicationController 
  
  def new
    @user = User.new
  end

  def create
    
  end


  
  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :seller)
  end
end