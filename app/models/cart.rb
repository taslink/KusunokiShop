class Cart < ActiveRecord::Base
    belongs_to :user
    
    # dependency: :destroy >> Cartの削除と同時にLineItemsも削除
    has_many :line_items, dependent: :destroy
    has_many :products, through: :line_items
    
    validates :user_id, presence: true
    validates :amount, presence: true , numericality: {only_integer: true, greater_than_or_equal_to: 360}
end