class Order < ActiveRecord::Base
    
    belongs_to :users
    has_many :orderdetails
    has_many :products, through: :orderdetails
    
end
