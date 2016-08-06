class ChangeDatatypeMainImageOfProduts < ActiveRecord::Migration
  def change
    change_column :products, :main_image, :string
  end
end
