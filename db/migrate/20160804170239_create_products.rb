class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_code
      t.string :name
      t.text :description
      t.integer :price
      t.string :product_type
      t.string :main_image
      t.string :sub1_image
      t.string :sub2_image

      t.timestamps null: false
    end
  end
end
