class CreateOders < ActiveRecord::Migration[6.1]
  def change
    create_table :oders do |t|
     t.string :delivery_postal_code, null: false  
     t.string :delivery_address, null: false  
     t.string :delivery_name, null: false  
     t.integer :payment, null: false, default:0  
     t.integer :total_payment, null: false  
     t.integer :postage, null: false  
     t.integer :order_status, null: false, default:0 
     t.timestamps
    end
  end
end
