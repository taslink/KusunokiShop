class Ordercustomform
   
   include ActiveModel::Model
   
   attr_accessor :envelope_id, :envelope_count, :card_id, :card_count
   
   validates :envelope_id, presence: true
   validates :envelope_count, presence: true
   validates :card_id, presence: true
   validates :card_count, presence: true

end