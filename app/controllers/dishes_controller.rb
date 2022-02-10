class DishesController < ApplicationController

  def add_to_cart
    new_cart_product = current_cart.order_dishes.build(dish: dish, count: 1,price: dish.price)
    new_cart_product.save
    respond_to do |f|
      f.json do
        render json:{ count: current_cart.order_dishes.count}
      end
    end
  end

  def remove_from_cart
    if cart_dish = current_cart.order_dishes.find_by(dish_id: dish.id)
      cart_dish.delete
    end
    respond_to do |f|
      f.json do
        render json:{ count: current_cart.order_dishes.count}
      end
    end
  end

  def cart
     @dishes = current_cart.order_dishes.includes(dish: [image_attachment: [:blob]])
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def dish
    @dish ||= Dish.find(params[:id])
  end

end
