class CreateDishes < ActiveRecord::Migration[6.1]
  def change
    create_table :dishes do |t|
      t.string :name,null:false
      t.string :name_en
      t.float :price, default: 0.0,null:false
      t.integer :category_id,null:false
      t.string :weight, default: "", null: false
      t.string :description, default: ""
      t.string :description_en, default: ""
      t.boolean :is_published, default: false,null:false
      t.boolean :is_delivered, default: false,null:false
      t.boolean :is_active_from_delivered, default: false, null:false

      t.timestamps
    end
  end
end
