#class Cart
  #attr_reader :items, :line_items
  #def initialize
    #@items = []
    #@line_items = []
  #end

  #def add_product(product)
    #@line_items << product
    #@items << @line_items
  #end
#end

class Cart < ActiveRecord::Base
    belongs_to :user
    
    # dependency: :destroy >> Cartの削除と同時にLineItemsも削除
    has_many :cart_pockets, dependent: :destroy
    has_many :line_items, through: :cart_pockets
    
    #validates :user_id, presence: true
    #validates :amount, presence: true , numericality: {only_integer: true, greater_than_or_equal_to: 360}
end