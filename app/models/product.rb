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

  scope :order_by_time, ->{order(:name, :price, :descriptions, created_at: :asc)}

  def new_product?
    created_at >= Settings.rules_new_product.days.ago
  end

  def show_img
    path = ActionController::Base.helpers.image_path(Settings.picture.default)
    images.first.image_url || path
  end
end
