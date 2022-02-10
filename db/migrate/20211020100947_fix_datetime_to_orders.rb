class FixDatetimeToOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :delivery_date
    remove_column :orders, :delivery_time
    add_column :orders, :delivery_at, :datetime,default: DateTime.now, null: false
  end
end
