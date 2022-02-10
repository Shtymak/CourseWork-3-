# frozen_string_literal: true

class DishComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(dish:)
    @dish = dish
  end

end
