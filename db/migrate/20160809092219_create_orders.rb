class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :address_id
      t.integer :amount
      t.integer :tax
      t.integer :pay_commission
      t.integer :postage
      t.string :payment_type
      t.string :shipping_type
      t.string :note

      t.timestamps null: false
    end
  end
end