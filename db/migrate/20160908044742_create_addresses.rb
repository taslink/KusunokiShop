class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :addressee
      t.string :zipcode
      t.string :prefecture_name
      t.string :city
      t.string :street
      t.string :building

      t.timestamps null: false
    end
  end
end
