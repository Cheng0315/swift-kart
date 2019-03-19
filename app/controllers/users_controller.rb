class UsersController < ApplicationController 

  #home page, find current user, set today's deals, trendings etc
  def index
    @user = current_user
    @todays_deal = todays_deal
    @trending_items = trending_items
    @recommended_items = recommended_items
    @featured_items = featured_items
    @listing_prices = [1399.99, 699.99, 79.99]
  end

  #create new user
  def new
    
    if current_user
      redirect_to root_path
    else
      @user = User.new
      render :layout => 'signin_signup'
    end
  end

  #save user to the database
  def create
    @user = User.new(users_params)
  
    if @user.save 
      session[:user_id] = @user.id
      redirect_to cart_user_cart_path
    else
      render :new, :layout => 'signin_signup'
    end
  end

  #show user's info
  def show
    @user = User.find(params[:id])
    @items_for_sale = @user.items
  end

  #edit user info
  def edit
    if current_user && params[:id].to_i == current_user.id
      @user = current_user
    else
      redirect_to signin_path
    end
  end

  #update user info to the database
  def update
    if current_user
      update_user_info
    else
      redirect_to signin_path
    end
  end



  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :seller, :uid)
  end

end