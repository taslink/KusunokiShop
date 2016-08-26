class RenameTitleColumnToCarts < ActiveRecord::Migration
  def change
    rename_column :carts, :amount_integer, :amount
  end
end