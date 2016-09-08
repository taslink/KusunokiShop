class Orderdetail < ActiveRecord::Base
    
    belongs_to :order
    belongs_to :product
    
    validates :product_id, presence: true
    validates :product_type, presence: true 
    
    validates :count, 
      presence: true,
      numericality: {only_integer: true, greater_than_or_equal_to: 1}
    
    validates :order_id, presence: true
    
end
