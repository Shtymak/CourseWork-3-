class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name,null:false
      t.string :name_en 

      t.timestamps
    end
  end
end
