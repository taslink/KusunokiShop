class Order < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :address
    has_many :orderdetails
    has_many :products, through: :orderdetails
    
    validates :user_id, presence: true
    
    validates :amount,
      presence: true,
      numericality: {only_integer: true}
    
end
