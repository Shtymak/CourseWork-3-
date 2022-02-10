class Group < ApplicationRecord
  include ActsAsDefaultImage

  has_many :categories

end
