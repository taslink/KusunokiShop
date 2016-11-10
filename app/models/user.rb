class User < ActiveRecord::Base
  has_one :address
  has_one :cart
  has_many :cart_pockets, through: :cart
  has_many :orders
  has_many :orderdetails, through: :oders

  #データの保存前にメールアドレスのアルファベットを小文字に
  #before_save { self.email = self.email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  
end