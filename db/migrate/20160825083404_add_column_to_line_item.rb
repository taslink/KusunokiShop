class AddColumnToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :product_type, :string
    add_column :line_items, :count, :integer
  end
end
