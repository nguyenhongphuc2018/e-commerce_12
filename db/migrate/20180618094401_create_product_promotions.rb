class CreateProductPromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :product_promotions do |t|
      t.integer :percent
      t.references :product, foreign_key: true
      t.references :promotion, foreign_key: true

      t.timestamps
    end
  end
end
