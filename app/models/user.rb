class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :heroes
  has_many :equipments

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
