class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end 

  def logged_in?
    !!current_user
  end 

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to perform that action!"
      redirect_to root_path
    end 
  end 

  def user_authenticated
    if logged_in?
      redirect_to user_path
    else
      redirect_to login_path
    end
  end

end
