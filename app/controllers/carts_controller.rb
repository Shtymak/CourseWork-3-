class CartsController < ApplicationController
  include TimeHelper
  def show
    @order = Order.new
    @dishes = current_cart.order_dishes.includes(dish: [:variants, image_attachment: [:blob]])
    @order_sum = @dishes.map { |order_dish| order_dish.count * order_dish.dish.price }.sum
    @mindate = DateTime.now.hour > 21 ? DateTime.now.next_day : DateTime.now
    @minhour = get_order_min_hour(@mindate)
    @minutes = get_order_avaible_minutes(@minhour)
  end

  def clear_cart
    current_cart.order_dishes.delete_all
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_name, :address, :lontigitude, :latitude, :self_pickup, :payment_id, :description, :promo_code_id, :state, :delivery_time, :phone, :delivery_date, :payment_type)
  end

  def user_params
    params.require(:order).permit(:user_name, :phone)
  end
end
