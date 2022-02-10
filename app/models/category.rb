class Category < ApplicationRecord
  include ActsAsDefaultImage

  has_many :dishes
  belongs_to :group, optional: true
  default_scope ->{order(:sequence_number)}

  scope :without_group, ->{where(group_id: nil)}

end
