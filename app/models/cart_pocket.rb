class CartPocket < ActiveRecord::Base
    belongs_to :cart
    has_many :line_items, dependent: :destroy
    has_many :products, through: :line_items
end
