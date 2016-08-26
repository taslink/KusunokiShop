class ChangeDatatypeTitleOfCarts < ActiveRecord::Migration
  def change
    change_column :carts, :amount, :integer
  end
end