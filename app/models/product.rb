class Product < ActiveRecord::Base
  has_many :orderdetails
  has_many :orders, through: :orderdetails
  has_many :line_items
  has_many :carts, through: :line_items
  
  # 破棄する前にLineitemが空か確認する
  before_destroy :not_line_item?
  
  mount_uploader :main_image, ImageUploader
  mount_uploader :sub1_image, ImageUploader
  mount_uploader :sub2_image, ImageUploader

  validates :product_code, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true,length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :product_type, presence: true
  validates :price, presence: true, numericality: {only_integer: true}

  private
  
  def not_line_item?
    # 関連するLineitemが空でないか検証
    if line_items.empty?
      return true
    else
      errors.add(:base, "カートの中に商品があります")
      return false
    end
  end

end