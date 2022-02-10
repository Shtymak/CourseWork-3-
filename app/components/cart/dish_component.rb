# frozen_string_literal: true

class Cart::DishComponent < ViewComponent::Base
  include ApplicationHelper

  with_collection_parameter :order_dish

  def initialize(order_dish:)
    @order_dish = order_dish
    @dish = @order_dish.dish
  end

end
