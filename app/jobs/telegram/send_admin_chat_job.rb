class Telegram::SendAdminChatJob < ApplicationJob
  queue_as :default

  def perform(text)
    ::TelegramNotification.new.send_message(text)
  end
end
