class ChangeDatatypeSub1ImageOfProduts < ActiveRecord::Migration
  def change
    change_column :products, :sub1_image, :string
  end
end
