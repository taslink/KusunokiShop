class CartPocket < ActiveRecord::Base
    belongs_to :cart
    has_many :line_items, dependent: :destroy
    has_many :products, through: :line_items
    
    validates :amount, presence: true , numericality: {only_integer: true, greater_than_or_equal_to: 360}    
end
