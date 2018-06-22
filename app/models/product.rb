class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :ratings
  has_many :comments
  has_many :type_products
  has_many :product_promotions
  has_many :images, dependent: :destroy

  validates :name, :price, :descriptions, presence: true

  scope :search, (lambda do |keyword|
    keyword = keyword.to_s.strip
    unless keyword.blank?
      joins(:category).where "categories.name LIKE ? or products.name LIKE ?
      or price LIKE ? ", "%#{sanitize_sql_like keyword}%",
        "%#{sanitize_sql_like keyword}%", "%#{sanitize_sql_like keyword}%"
    end
  end)
end
