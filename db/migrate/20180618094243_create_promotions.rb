class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.text :description

      t.timestamps
    end
  end
end
