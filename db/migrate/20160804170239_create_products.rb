class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_code
      t.string :name
      t.text :description
      t.integer :price
      t.string :type
      t.binary :main_image
      t.binary :sub1_image
      t.binary :sub2_image

      t.timestamps null: false
    end
  end
end
