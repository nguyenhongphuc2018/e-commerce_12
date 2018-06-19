class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :ratings
  has_many :comments
  has_many :type_products
  has_many :product_promotions

  validates :name, :descriptions, presence: true
end
