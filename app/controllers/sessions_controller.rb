class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_email(params[:session][:email])
    
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "User is successfully logged in"
      redirect_to '/'
    else 
      flash[:danger] = "Please check the username & password"
      render 'new'
    end
  end
  
  def destroy
    log_out
    flash[:success] = "User is successfully logged out."
    redirect_to '/'
  end
end
