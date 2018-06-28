class TypeProduct < ApplicationRecord
  belongs_to :product
  scope :search, (lambda do |keyword|
    sql_statement = "products.name LIKE ? 
      or type_products.size LIKE ? 
      or type_products.color LIKE ? 
      or type_products.quantity LIKE ? 
      or products.id LIKE ? "
    keyword = keyword.to_s.strip
    unless keyword.blank?
      joins(:product).where sql_statement, 
        "%#{sanitize_sql_like keyword}%", 
        "%#{sanitize_sql_like keyword}%", "%#{sanitize_sql_like keyword}%", 
        "%#{sanitize_sql_like keyword}%", "%#{sanitize_sql_like keyword}%" 
    end
  end)
end
