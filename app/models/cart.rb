class Cart < ActiveRecord::Base
    
    belongs_to :user
    
    # dependency: :destroy はCartの破棄と同時にLineItemも破棄
    has_many :line_items, dependent: :destroy
    
    has_many :products, through: :line_items
    
end