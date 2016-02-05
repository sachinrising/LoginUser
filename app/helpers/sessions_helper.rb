module SessionsHelper

	  def current_user

    if user_id = session[:user_id]
    
      @current_user ||= User.find_by(id: user_id)
    
    elsif user_id1 = cookies.permanent.signed[:user_id]
      
      @current_user ||= User.find_by(id: user_id1)

      @current_user = nil if @current_user.nil? || !@current_user.isDigestAuthenticated(cookies.permanent.signed[:remember_id]) 
      
      @current_user
    end

  end
  
  def is_logged_in
    !current_user.blank?
  end
  
  def log_out
   
    if current_user
      current_user.forget_remember_id
    end
    
    session.delete(:user_id)
    cookies.delete(:user_id)
    cookies.delete(:remember_id)
    @current_user = nil
  end

  def remember_me(user)
    user.remember_me
    debugger
    puts "User_ID: #{user.id}"
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_id] = user.remember_token
  end
  
end
