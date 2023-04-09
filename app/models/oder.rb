class Oder < ApplicationRecord
     
     has_many :order_details, dependent: :destroy
 
     enum payment: 
     {credit_card: 0, transfer: 1 }
     
     enum order_status:
     { waiting: 0, paid_up: 1, in_production: 2, preparing: 3, shipped: 4 }
     
     
end
