class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callback]

  def create
    # якщо користувач написав інше ім'я але той самий телефон значить це той самий користувач
    @user = User.find_by(phone: user_params[:phone]) || User.create(user_params)
    if @user
      @order = @user.orders.build(order_params)

      data = params[:order][:delivery_date].split('-').map(&:to_i)
      minute = params[:order][:minute]
      @order.delivery_at = DateTime.new(data[0], data[1], data[2], params[:order]['delivery_time(4i)'].to_i, minute.to_i)

      @order.user_name = user_params[:name]

      if @order.save
        params[:order][:order_dishes].each do |id, dish_params|
          order_dish = current_cart.order_dishes.find_by(id: id)
          order_dish.update(
            order: order,
            variant_name: dish_params[:variant_name],
            count: dish_params[:count],
            price: order_dish.dish.price,
            cart_id: nil
          )
        end

        if Order.payment_types[order.payment_type] == 0
          redirect_to pay_order_path(order)
        else
          flash[:success] = I18n.t('cart.success')
          Telegram::SendAdminChatJob.perform_later(order_text(@order, @user))
          @order.send_message
          redirect_to root_path
        end
      end
    else
      flash[:error] = I18n.t('cart.error')
      redirect_back(fallback_location: root_path)
    end
  end

  def pay
    order
    @pay = Pay.create(sum: order.sum_price, status: 'Очікує', client_id: order.payment_id,
                      details: 'Замовлення очікує на оплату', order_id: order.id)
    # Telegram::SendAdminChatJob.perform_later("#{User.find(order.user_id).user_name} оплачує замолення №#{order.id}")
    render 'carts/pay'
  end

  def callback
    @pay = Pay.find_by(order_id: order.id)
    if params[:order_status] == 'approved'
      flash[:success] = I18n.t('cart.payed')
      order.update(payment_id: params[:payment_id], state: 1)
      @pay.update(status: 'Успішно', client_id: params[:payment_id], details: "Картка: #{params[:masked_card]}")
      Telegram::SendAdminChatJob.perform_later(order_text(order, User.find_by(id: order.user_id)))
      order.send_message
    else
      @pay.update(status: 'Збій', details: "Картка: #{params[:masked_card]}")
      flash[:error] = I18n.t('cart.error_payed')
      order.update(state: 0)
    end
    redirect_to root_path
  end

  private

  def order
    @order ||= Order.find(params[:id])
  end

  def active_promo_code
    code = PromoCode.find_by(code: params[:order][:promo_code_id])
    if !code.nil? && code.is_activated == false && code.valid_until > DateTime.now
      code.update(user_id: @user.id, is_activated: true)
    # TODO: має змінювати ціну , зробити щоб працював параелельно у формі перез оплатою та іншим
    else
      flash[:error] = I18n.t('cart.promo_error')
    end
  end

  def get_order_sum_price
    order.order_dishes.map(&:sum_price).sum.ceil(2)
  end

  def order_text(order, user)
    dishes = ''
    order.order_dishes.each do |order_dish|
      dishes += "  #{order_dish.dish.name}(#{order_dish.variant_name}) Кількість: #{order_dish.count}\nЦіна за одиницю: #{order_dish.price}грн., ціна за (#{order_dish.count})шт.: #{order_dish.count * order_dish.price}грн.\n\n"
    end
    text = "ЗАМОВЛЕННЯ\n
    Користувач: #{order.user_name}(Телефон: #{user.phone})\n
    Адреса: #{order.address}\n
    Тип доставки: #{Order.self_pickups[order.self_pickup] == 0 ? 'Доставка' : 'Самовивіз'}\n
    Тип оплати: #{Order.payment_types[order.payment_type] == 0 ? 'Картка' : 'Готівка'}(#{Order.states[order.state] == 1 ? order.state.to_s.upcase : order.state})\n
    Час: #{order.delivery_at.strftime('%H:%M %F')}\n
    Страви:\n\n#{dishes}\n
    Загальна сума: #{order.sum_price} грн.\n
    Посилання: balu.kiev.ua#{admin_order_path(order)}"
    text += "\n Коментар #{order.description}" unless order.description.blank?
    text
  end

  def order_params
    params.require(:order).permit(:user_name, :address, :lontigitude, :latitude, :self_pickup, :payment_id,
                                  :description, :state, :phone, :payment_type, :delivery_sum)
  end

  def user_params
    params[:order].require(:user).permit(:name, :phone)
  end
end
