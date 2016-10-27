class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_code
      t.string :name
      t.text :description
      t.integer :price
      t.string :product_type
      t.string :jan_code
      t.string :main_image
      #t.boolean :remove_main_image
      #t.string :main_image_cache
      t.string :sub1_image
      #t.boolean :remove_sub1_image
      #t.string :sub1_image_cache
      t.string :sub2_image
      #t.boolean :remove_sub2_image
      #t.string :sub2_image_cache
      
      t.timestamps null: false
    end
  end
end
