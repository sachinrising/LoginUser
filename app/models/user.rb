require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt
  
  has_secure_password
  
  validates :email, presence: true, length: {minimum: 5}, uniqueness: true
  validates :password, presence: true, length: {minimum: 5, maximum: 15}

  attr_accessor :remember_token

def newToken
	SecureRandom.urlsafe_base64
end

def remember_me
	self.remember_token = newToken
  	update_attribute(:remember_digest, Password.create(remember_token))
end

def forget_remember_id
   	update_attribute(:remember_digest, nil)
end

def isDigestAuthenticated(string)
	return false if remember_digest.nil? || string.nil?
	Password.new(remember_digest).is_password?(string)
end

def send_activation
  debugger
  UserMailer.account_activation(self).deliver_now
end

end
