class ApplicationController < ActionController::Base
  include FlashHelper
  before_action :current_cart
  before_action :set_locale

  rescue_from Exception, with: :send_to_telegram if Rails.env.production?

  def send_to_telegram(e)
    log = Log.create(message: e.message,
                     params: params,
                     backtraces: e.backtrace.join('<br>'),
                     referer: request.referer,
                     user_agent: request.user_agent)

    Telegram::SendAdminChatJob.perform_later("picBu\n #{e.message} \nlocalhost/#{admin_log_path(log.id)}")
    render file: 'public/500.html', layout: false, status: 500
  end

  def default_url_options(options = {})
    {
      locale: I18n.locale
    }.merge options
  end

  def current_cart
    @current_cart ||= if session[:cart_id] && Cart.find_by_id(session[:cart_id])
                        Cart.find(session[:cart_id])
                      else
                        cart = Cart.create!
                        session[:cart_id] = cart.id
                        cart
                      end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    $config_view = ConfigView.find_by(locale: I18n.default_locale.to_s.downcase)
  end
end
