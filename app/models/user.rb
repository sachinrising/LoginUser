class User < ActiveRecord::Base
  has_secure_password
  
  validates :email, presence: true, length: {minimum: 5}, uniqueness: true
  validates :password, presence: true, length: {minimum: 5, maximum: 15}
end
