class User < ApplicationRecord
  has_many :api_keys, as: :bearer

  has_secure_password

  validates :password, confirmation: true
  validates :email, uniqueness: true, presence: true, allow_empty: false
  validates :password, presence: { require: true, allow_empty: false }
  validates :password_confirmation, presence: { require: true, allow_empty: false }
end
