class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :payment_type
      t.string :shipping_type
      t.string :shipping_prefecture

      t.timestamps null: false
    end
  end
end
