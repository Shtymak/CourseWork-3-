class Booking < ApplicationRecord
  belongs_to :user

  def send_message()
    TurbosmsRuby.new.send_message([user.phone], "balu.kiev.ua\n#{user.name}, #{I18n.t('booking.thanks')} #{I18n.t('booking.save')} #{self.select_at.strftime('%Y-%m-%d %H:%M')}"
    )
  end
end
