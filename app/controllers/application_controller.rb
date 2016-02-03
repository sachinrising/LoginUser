class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :is_logged_in
  
  def current_user
      @current_user ||= User.find_by(id: session[:user_id]) unless session[:user_id].nil?
  end
  
  def is_logged_in
    puts "Current User: #{current_user}"
    !current_user.blank?
  end
  
  def log_out
    @curren_user = nil
    session.delete(:user_id)
  end
end
