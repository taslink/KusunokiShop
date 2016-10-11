class ChangeColumnToOrder < ActiveRecord::Migration
  # 変更内容
  def up
    change_column :orders, :user_id, :integer, null: false, index: true
    change_column :orders, :address_id, :integer, null: false, index: true
    change_column :orders, :amount, :integer, null: false
    change_column :orders, :tax, :integer, null: false
    change_column :orders, :pay_commission, :integer, null: false
    change_column :orders, :postage, :integer, null: false
    change_column :orders, :payment_type, :integer, null: false
    change_column :orders, :shipping_type, :integer, null: false
  end

  # 変更前の状態
  def down
    change_column :orders, :user_id, :integer
    change_column :orders, :address_id, :integer
    change_column :orders, :amount, :integer
    change_column :orders, :tax, :integer
    change_column :orders, :pay_commission, :integer
    change_column :orders, :postage, :integer
    change_column :orders, :payment_type, :integer
    change_column :orders, :shipping_type, :integer
  end
end