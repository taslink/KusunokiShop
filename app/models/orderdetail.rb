class Orderdetail < ActiveRecord::Base
    
    belongs_to :orders
    belongs_to :products
    
    #validates :product_id, presence: true
    #validates :product_type, presence: true 
    
    #validates :count, presence: true 
    
    #validates :order_id, presence: true
    
end
