class UsersController < ApplicationController 

  def index
    @user = current_user
    @todays_deal = todays_deal
    @trending_items = trending_items
    @recommended_items = recommended_items
    @feature_items = feature_items
  end

  def new
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(users_params)
  
    if @user.save 
      session[:user_id] = @user.id
      redirect_to cart_user_cart_path
    else
      render :new
    end
  end

  def edit
    if current_user && params[:id] == current_user.id
      @user = current_user
    else
      redirect_to signin_path
    end
  end

  def update
    if current_user
      update_user_info
    else
      redirect_to signin_path
    end
  end

  def show
    if current_user
      show_user_info
    else
      redirect_to root_path
    end
  end



  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :seller, :uid)
  end

end