class Category < ApplicationRecord
  belongs_to :user
  has_many :product

  validates :name, presence: true,
    length: {maximum: Settings.category.name.maximums}
end
