class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :is_logged_in
  
  @current_user = nil
  
  def current_user
    
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id]
    else
      @current_user ||= User.find_by(id: cookies.permanent.signed[:user_id])
      
      if !@current_user.nil? && !@current_user.isDigestAuthenticated(:remember_digest, cookies.permanent.signed[:remember_id])
        @current_user = nil
      end
      
      @current_user
    end
  end
  
  def is_logged_in
    #puts "Current User: #{current_user}"
    !current_user.blank?
  end
  
  def log_out
    @debugger
    puts "current_user: #{@current_user}"
    User.forget_remember_id(current_user)
    session.delete(:user_id)
    cookies.delete(:user_id)
    cookies.delete(:remember_id)
    @current_user = nil
  end
end
