class CreateCartPockets < ActiveRecord::Migration
  def change
    create_table :cart_pockets do |t|
      t.integer :cart_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
