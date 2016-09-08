class RemovePostalcodeToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :postalcode, :integer
  end
end
