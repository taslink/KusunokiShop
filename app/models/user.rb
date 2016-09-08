class User < ActiveRecord::Base
  
  has_many :orders
  has_many :orderdetails, through: :oders
  
  has_many :carts
  has_many :line_items, through: :carts
  
  has_one :address
  
  #データの保存前にメールアドレスのアルファベットを小文字に
  before_save { self.email = self.email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
end
