class Address < ActiveRecord::Base
    belongs_to :user
    has_many :orders
    
    validates :user_id, uniqueness: true, allow_nil: true    
    validates :addressee, presence: true
    validates :zipcode, presence: true
    validates :prefecture_name, presence: true
    validates :city, presence: true
    validates :street, presence: true
end