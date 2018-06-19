class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address
      t.datetime :birthday
      t.string :phone
      t.string :avatar
      t.integer :provider, default: 0
      t.string :uid
      t.integer :role, default: 1
      t.boolean :verified, default: false
      t.string :activation_digest
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_send_at

      t.timestamps
    end
  end
end
