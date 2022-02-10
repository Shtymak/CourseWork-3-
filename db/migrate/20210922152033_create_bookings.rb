class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.string :user_name
      t.integer :user_id
      t.datetime :select_at
      t.integer :person_count
      t.string :description

      t.timestamps
    end
  end
end
