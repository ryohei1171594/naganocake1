class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :item
    
    validates :amount, presence: true

    enum status:

        {

          impossible_manufacture:0,
          waiting_manufacture:1,
          manufacturing:2,
          finish:3

        }
end
