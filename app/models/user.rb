class User < ApplicationRecord
  has_many :recipes
  has_many :comments
  has_many :ratings

  validates :user_name, presence: true
  validates :email, uniqueness: true, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :email, confirmation: true

  has_secure_password
end
