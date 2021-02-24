class UsersController < ApplicationController 
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name} to Soccer Star!"
      redirect_to user_path(@user)
    else
      flash[:error] = "Something went wrong, please try again!"
      redirect_to signup_path
    end
  end

  def show
    if current_user.id != params[:id].to_i   
      redirect_to user_path(current_user)
    end 
      redirect_to '/' if !logged_in?
  end


  def edit
    @user = User.find_by_id(params[:id])
  end 

  def update 
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      flash[:success] = "user was updated successfully"
      redirect_to user_path(@user)
    else 
      render 'edit'
    end 
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :image_url)
  end 


end
 