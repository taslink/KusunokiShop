class LineItem < ActiveRecord::Base
    belongs_to :cart_pocket
    belongs_to :product
    
    validates :cart_pocket_id, presence: true
    validates :product_id, presence: true
    validates :product_type, presence: true
    validates :count, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
end
