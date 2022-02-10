class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :user_name
      t.integer :user_id, null: false
      t.string :address
      t.string :longitude
      t.string :latitude
      t.integer :self_pickup, default: 0, null: false
      t.integer :payment_id
      t.integer :state, default: 0, null: false
      t.string :description
      t.integer :promo_code_id
      t.datetime :delivery_date, default: DateTime.now, null: false
      t.datetime :delivery_time, default: DateTime.now, null: false
      t.integer :payment_type, default: 0, null: false

      t.timestamps
    end
  end
end
