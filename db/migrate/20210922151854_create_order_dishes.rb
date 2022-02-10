class CreateOrderDishes < ActiveRecord::Migration[6.1]
  def change
    create_table :order_dishes do |t|
      t.integer :order_id
      t.integer :dish_id,null:false
      t.integer :cart_id
      t.float :price,null:false
      t.integer :count,default: 1,null:false
      t.string :variant_name,default:"" 

      t.timestamps
    end
  end
end
