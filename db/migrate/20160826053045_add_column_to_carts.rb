class AddColumnToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :user_id, :integer
    add_column :carts, :amount_integer, :string
  end
end
