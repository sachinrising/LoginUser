class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user && @user.save
      session[:user_id] = @user.id
      flash[:success] = "User is successfully signed up"
      @user.send_activation
      redirect_to '/'
    else
      flash[:danger] = "User is not successfully created"
      render 'new'
    end
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
