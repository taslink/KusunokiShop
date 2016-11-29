class AddSortNoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sort_no, :integer
  end
end
