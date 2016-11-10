class Address < ActiveRecord::Base
    belongs_to :user
    has_many :orders
    
    validates :user_id, uniqueness: true, allow_nil: true    
    validates :addressee, presence: true
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :order_email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    
    validates :zipcode, presence: true
    validates :prefecture_name, presence: true
    validates :city, presence: true
    validates :street, presence: true
end