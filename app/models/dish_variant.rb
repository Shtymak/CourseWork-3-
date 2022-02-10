class DishVariant < ApplicationRecord
  belongs_to :dish
  belongs_to :variant
end
