class AddPrefectureToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :prefecture, :string
  end
end
