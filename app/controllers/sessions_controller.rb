class SessionsController < ApplicationController

  def index 
    if logged_in? 
      redirect_to user_path(@current_user)
    end
  end 

  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email])
      if @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        flash[:message] = "You have successfully logged in"
        redirect_to user_path(@user.id)
      else
        flash[:error] = "Something went wrong, please try again."
        redirect_to login_path
      end 
  end

  def google 
    @user = User.find_or_create_by(email: auth["info"]["email"]) do |user|
      user.name= auth["info"]["first_name"]
      user.password= SecureRandom.hex(10)
    end 
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to '/'
    end 
  end 

  def destroy 
    session.delete(:user_id) 
    flash[:message] = "You have logged out!"
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end   

end 