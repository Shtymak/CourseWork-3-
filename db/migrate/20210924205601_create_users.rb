class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name,default: "user"
      t.string :phone,null:false
      t.string :description,default: ""

      t.timestamps
    end
  end
end
