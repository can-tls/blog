class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_one_attached :avatar
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  # has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, if: lambda { new_record? || !password.blank? }
  validates_confirmation_of :password

  enum role: { admin: 0, user: nil }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def defaultpw_valid?(params)  
    defaultpw == params
  end
  
#
end