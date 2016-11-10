class Cart < ActiveRecord::Base
    belongs_to :user
    
    # dependency: :destroy >> Cartの削除と同時にLineItemsも削除
    has_many :cart_pockets, dependent: :destroy
    has_many :line_items, through: :cart_pockets
    
    #validates :user_id, presence: true

end