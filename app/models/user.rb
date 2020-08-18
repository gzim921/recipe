class User < ApplicationRecord
  has_many :recipes
  has_many :ratings

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :user_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
                    uniqueness: true

  validates :email, confirmation: true

  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  before_save :email_to_downcase


  private

  def email_to_downcase
    self.email = email.downcase
  end
end
