class ChangeDatatypeSub2ImageOfProduts < ActiveRecord::Migration
  def change
    change_column :products, :sub2_image, :string
  end
end
