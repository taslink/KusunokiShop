class LineItem < ActiveRecord::Base
    belongs_to :cart
    belongs_to :product
    
    validates :product_id, presence: true
    validates :cart_id, presence: true
    validates :product_type, presence: true
    validates :count, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
end
