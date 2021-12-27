class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :postal_code
      t.string :adderss
      t.string :name
      t.integer :postsge
      t.integer :total_price
      t.integer :payment_method
      t.integer :order_status

      t.timestamps
    end
  end
end
