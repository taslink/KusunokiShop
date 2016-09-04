class Product < ActiveRecord::Base
  mount_uploader :main_image, ImageUploader
  mount_uploader :sub1_image, ImageUploader
  mount_uploader :sub2_image, ImageUploader
  
  has_many :orderdetails
  has_many :orders, through: :orderdetails
  
  has_many :line_items
  has_many :carts, through: :line_items

  # 破棄する前にLineitemが空か確認する
  before_destroy :not_line_item?

  validates :product_code,
    presence: true,
    uniqueness: { case_sensitive: false }

  validates :name, length: { maximum: 100 },
    presence: true,
    uniqueness: { case_sensitive: false }

  validates :price,
    presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 10}

  private
  
  def not_line_item?
  # 関連する品目が空でないか検証
  if line_items.empty?
    return true
  else
    errors.add(:base, "品目が存在します")
    return false
  end
  
  end

end
