class UsersController < ApplicationController 

  def index
    @user = current_user
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

  def edit

    if current_user
      @user = current_user
    else
      redirect_to login_path
    end
  end

  def update

    if current_user
      @user = current_user
      @user.update(users_params)
      redirect_to user_path(@user)
    else
      redirect_to edit_user_path
    end
  end

  def show
    if current_user
      @user = current_user
    else
      redirect_to root_path
    end
  end



  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :seller)
  end

end