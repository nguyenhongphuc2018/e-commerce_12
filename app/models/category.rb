class Category < ApplicationRecord
  belongs_to :user
  has_many :product, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.category.name.maximum,
             too_long: I18n.t("validate.maximum")}
  scope :search, (lambda do |keyword|
    keyword = keyword.to_s.strip
    where "name LIKE ?", "%#{sanitize_sql_like keyword}%" unless keyword.blank?
  end)
end
