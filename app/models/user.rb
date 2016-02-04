require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  
  has_secure_password
  
  validates :email, presence: true, length: {minimum: 5}, uniqueness: true
  validates :password, presence: true, length: {minimum: 5, maximum: 15}

  attr_accessor :remember_digest

def newToken
	SecureRandom.urlsafe_base64
end

def remember_me
	@token = Password.create(newToken)
    self.remember_digest = @token
end

end
