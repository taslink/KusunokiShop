class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :address
    # dependency: :destroy >> Orderの削除と同時にorderdetailsも削除
    has_many :orderdetails, dependent: :destroy
    has_many :products, through: :orderdetails
    
    validates :user_id, presence: true
    validates :amount, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 360}
end
