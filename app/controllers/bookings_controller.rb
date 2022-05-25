class BookingsController < ApplicationController
  include TimeHelper

  def new
    @mindate = DateTime.now.hour >= 21 ? DateTime.now.next_day : DateTime.now
    @minhour = get_min_hour(@mindate)
    @minutes = get_booking_avaible_minutes(@mindate)
  end

  def create
    @user = User.find_by(phone: user_params[:phone]) || User.create(user_params)
    if @user
      booking = @user.bookings.build(booking_params)
      data = params[:booking][:select_date].split('-').map(&:to_i)
      minute = params[:booking][:minute]
      booking.select_at = DateTime.new(data[0], data[1], data[2], params[:booking]['select_time(4i)'].to_i, minute.to_i)
      booking.user_name = @user.name
      if booking.save
        Telegram::SendAdminChatJob.perform_later(booking_text(booking, @user))
        flash[:success] = I18n.t('booking.thanks')
        booking.send_message()
        redirect_to root_path
      end
    else
      flash[:error] = I18n.t('booking.error_message')
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def booking_text(booking, user)
    text = "БРОНЬ
    #{user.name}(Телефон: #{user.phone}) зробив(ла) резевр\n\n" +
      "Дата і час:#{booking.select_at.strftime('%H:%M %F')}\n\n" +
      "Кількість людей: #{booking.person_count}\n\n" +
      "Коментар: #{booking.description}\n\n" +
      "Посилання: picbu.ua#{admin_booking_path(booking)}"
    text
  end

  def booking_params
    params.required(:booking).permit(:user_id, :user_name, :phone, :person_count, :select_at, :description)
  end

  def user_params
    params[:booking].require(:user).permit(:name, :phone)
  end
end
