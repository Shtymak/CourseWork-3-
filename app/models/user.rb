class User < ApplicationRecord
  has_many :orders
  has_many :bookings

  has_many :promo_codes
end
