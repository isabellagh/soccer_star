class SessionsController < ApplicationController

  def index 
  end 

  def new
  end
  
  def create
    #byebug
  if auth 
    @user = User.find_or_create_by(email: auth["info"]["email"]) do |u|
      u.name = auth["info"]["name"]
      u.password = SecureRandom.hex(10)
      end 
    else
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
  end

  #def omniauth  
    #byebug  
  #  @user = User.google_signup(auth)
  #  session[:user_id] = @user.id
  #    redirect_to user_path(@user)
  #end 

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