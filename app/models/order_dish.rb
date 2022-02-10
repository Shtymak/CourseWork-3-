class OrderDish < ApplicationRecord
  belongs_to :dish
  belongs_to :order,optional: true
  belongs_to :cart,optional: true

  def sum_price
    (price*count).ceil(2)
  end
end
