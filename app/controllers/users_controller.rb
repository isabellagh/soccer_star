class UsersController < ApplicationController 
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Soccer Star, #{@user.name}!"
      redirect_to user_path(@user)
    else
      flash[:error] = "Something went wrong, please try again!"
      render 'new'
    end
  end

  def show
    set_user
    # if current_user.id != params[:id].to_i   
    #   redirect_to user_path(current_user)
    # end 
    #   redirect_to '/' if !logged_in?
  end

  def edit
    set_user
  end 

  def update 
    set_user
    if @user.update(user_params)
      flash[:success] = "user was updated successfully"
      redirect_to user_path(@user)
    else 
      render 'edit'
    end 
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to '/'
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :image_url)
  end 

  def set_user
    @user = User.find_by_id(params[:id])
  end 

  def require_same_user 
    if current_user != @user
      flash[:error] = "You can only edit or delete you own account"
      redirect_to @user
    end 
  end 

end
 