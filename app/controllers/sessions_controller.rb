class SessionsController < ApplicationController
  def new
  end
  
  def create

    @user = User.find_by_email(params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      
      session[:user_id] = @user.id
      
      params[:session][:remember] = 1 ? remember_me(@user) : @user.forget_remember_id

      flash[:success] = "User is successfully logged in"
      redirect_to '/'
    else 
      flash.now[:danger] = "Please check the username & password"
      render 'new'
    end
  end
  
  def destroy
    
    if is_logged_in
      log_out
    end

    flash[:success] = "User is successfully logged out."
    redirect_to '/'
  end
end
