class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :ratings
  has_many :comments
  has_many :type_products, dependent: :destroy
  has_many :product_promotions, dependent: :destroy
  has_many :images, dependent: :destroy
  validates :name, :price, :descriptions, presence: true
  accepts_nested_attributes_for :type_products, allow_destroy: true
  scope :new_products, (lambda do
                          where("created_at >= ?",
                            Settings.rules_new_product.days.ago)
                        .order("created_at desc")
                        end)

  scope :search, (lambda do |keyword|
    keyword = keyword.to_s.strip
    unless keyword.blank?
      joins(:category).where "categories.name LIKE ? or products.name LIKE ?
      or price LIKE ? ", "%#{sanitize_sql_like keyword}%",
        "%#{sanitize_sql_like keyword}%", "%#{sanitize_sql_like keyword}%"
    end
  end)

  scope :filter_by_price, (lambda do |min_price, max_price|
    unless min_price.blank? && max_price.blank?
      sql_statement = "price >= ? AND price <= ?"
      where(sql_statement, min_price, max_price).order(price: :asc)
    end
  end)

  scope :filter_by_color, (lambda do |color|
    color = color.to_s.strip
    unless color.blank?
      sql_statement = "type_products.color LIKE ? "
      joins(:type_products).where(sql_statement, color)
    end
  end)

  scope :filter_by_size, (lambda do |size|
    unless size.blank?
      sql_statement = "type_products.size LIKE ? "
      joins(:type_products).where(sql_statement, size)
    end
  end)

  scope :order_by_time,
    ->{order(:name, :price, :descriptions, created_at: :asc)}

  def new_product?
    created_at >= Settings.rules_new_product.days.ago
  end

  def show_img
    path = ActionController::Base.helpers.image_path(Settings.picture.default)
    images.first ? images.first.image_url : path
  end

  def show_all_img
    images.to_a.map(&:image_url)
  end
end
