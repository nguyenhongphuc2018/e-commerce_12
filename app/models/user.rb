class User < ApplicationRecord
  enum role: {banned: 0, member: 1, admin: 2}
  enum provider: {local: 0, facebook: 1, google: 2}

  has_many :ratings
  has_many :orders
  has_many :comments
  has_many :products, dependent: :destroy
  has_many :category, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,length: {maximum: Settings.user.email.maximum},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :address, presence: true,
    length: {maximum: Settings.user.address.maximum}
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.user.password.minimum}
end
