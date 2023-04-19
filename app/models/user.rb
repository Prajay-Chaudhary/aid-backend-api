class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :owned_requests,	class_name: "Request",	foreign_key: "owner_id"
  has_many_attached :files

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self




  # #validations 
  validates :first_name, :last_name, :username, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :username, uniqueness: true
  validates :email, uniqueness: true
end
