class CreateOderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :oder_details do |t|
      t.integer :amount, null: false
      t.integer :tax_price, null: false
      t.integer :production_status, null: false, default:0 
      t.timestamps
    end
  end
end
