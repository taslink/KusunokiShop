class CreateOrderdetails < ActiveRecord::Migration
  def change
    create_table :orderdetails do |t|
      t.integer :product_id
      t.string :product_type
      t.integer :count
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
