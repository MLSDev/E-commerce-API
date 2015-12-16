class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true

  validates :email, presence: true, uniqueness: true, email: true

  has_one :auth_token, dependent: :destroy
end
