class AddDeliverySumToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_sum, :float,default: 0,null:false
  end
end
