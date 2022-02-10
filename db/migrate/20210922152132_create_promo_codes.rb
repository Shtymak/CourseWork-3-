class CreatePromoCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :promo_codes do |t|
      t.string :code,null:false
      t.datetime :valid_until
      t.integer :user_id
      t.boolean :is_activated, default:false, null:false

      t.timestamps
    end
  end
end
