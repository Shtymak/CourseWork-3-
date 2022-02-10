class PromoCode < ApplicationRecord
  belongs_to :user,optional: true
end
