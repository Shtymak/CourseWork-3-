class Variant < ApplicationRecord
  has_many :dish_variants
  has_many :dishes, through: :dish_variants
end
