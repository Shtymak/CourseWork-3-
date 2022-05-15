class Order < ApplicationRecord
  attr_reader :promo_code
  before_update :order_state_change

  has_many :dishes, through: :order_dishes
  has_many :order_dishes
  belongs_to :user

  delegate :phone, to: :user
  attribute :minute

  enum state: {
    'нове' => 0,
    'оплачене' => 1,
    'відправлене' => 2,
    'завершене' => 3
  }

  enum payment_type: {
    'card' => 0, 'cash' => 1
  }

  enum self_pickup: {
    'delivery' => 0,
    'self_pickup' => 1
  }

  def sum_price
    order_dishes.map(&:sum_price).sum.ceil(2) + delivery_sum.ceil(2)
  end

  def send_message()
    # Telegram::SendAdminChatJob.perform_later("null")
    ::TurbosmsRuby.new.send_message([phone], "picbu.ua\n#{user.name}, #{I18n.t('cart.thanks')} #{I18n.t('cart.message_sum')} #{self.sum_price}"
    )
  end

  def order_state_change()
    if state_changed? && self.state != 'нове' && self.payment_type != 'card'
      send_message()
    end
  end
end
