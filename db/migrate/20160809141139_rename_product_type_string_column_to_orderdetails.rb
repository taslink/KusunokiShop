class RenameProductTypeStringColumnToOrderdetails < ActiveRecord::Migration
  def self.up
    rename_column :orderdetails, :product_type_string, :product_type
  end
  def self.down
    rename_column :orderdetails, :product_type, :product_type_string
  end
end
