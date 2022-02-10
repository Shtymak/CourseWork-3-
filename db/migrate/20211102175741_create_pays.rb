class CreatePays < ActiveRecord::Migration[6.1]
  def change
    create_table :pays do |t|
      t.float :sum
      t.string :client_id
      t.string :status
      t.string :details
      t.integer :order_id

      t.timestamps
    end
  end
end
