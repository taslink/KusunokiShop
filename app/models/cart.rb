class Cart < ActiveRecord::Base
    # dependency: :destroy はCartの破棄と同時にLineItemも破棄
    has_many :line_items, dependent: :destroy
end