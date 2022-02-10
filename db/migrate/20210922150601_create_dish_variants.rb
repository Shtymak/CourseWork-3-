class CreateDishVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :dish_variants do |t|
      t.integer :dish_id,null:false
      t.integer :variant_id,null:false

      t.timestamps
    end
  end
end
