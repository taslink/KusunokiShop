class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :address_id
      t.integer :amount
      t.integer :tax
      t.integer :postage

      t.timestamps null: false
    end
  end
end