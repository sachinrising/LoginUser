require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  
  has_secure_password
  
  validates :email, presence: true, length: {minimum: 5}, uniqueness: true
  validates :password, presence: true, length: {minimum: 5, maximum: 15}

  attr_accessor :remember_token

def User.newToken
	SecureRandom.urlsafe_base64
end

def User.remember_me(user)
	token = Password.create(newToken)
	self.remember_token = token
  user.update_attribute(:remember_digest, token)
end

def User.forget_remember_id(user)
  if !user.nil?
    user.update_attribute(:remember_digest, nil)
  end
end

def isDigestAuthenticated(:column, string)
  Password.new(:column).is_password?(string)
end

end
