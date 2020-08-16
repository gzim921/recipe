class User < ApplicationRecord
  has_many :recipes
  has_many :comments
  has_many :ratings

  validates :user_name, uniqueness: true, presence: true
  validates :email, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_secure_password
end
