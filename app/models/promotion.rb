class Promotion < ApplicationRecord
  has_many :product_promotions

  validates :start_date, :end_date, :descriptions, presence: true
end
