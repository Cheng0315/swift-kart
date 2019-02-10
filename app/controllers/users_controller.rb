class UsersController < ApplicationController 

  def index
    @user = current_user
    @items = Item.all
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

    if current_user
      @user = current_user
    else
      redirect_to login_path
    end
  end

  def update

    if current_user
      @user = current_user
      @user.first_name = params[:user][:first_name]
      @user.last_name = params[:user][:last_name]
      @user.email = params[:user][:email]
      @user.password_digest = params[:user][:password]

      if @user.valid?
        @user.update(users_params)
        redirect_to user_path(@user)
      else  
        render :edit
      end
    else
      redirect_to login_path
    end
  end

  def show
    
    if current_user
    
      if params[:id].to_i != current_user.id
        redirect_to user_path(current_user)
      else
        @user = current_user
      end
    else
      redirect_to root_path
    end
  end



  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :seller)
  end

end