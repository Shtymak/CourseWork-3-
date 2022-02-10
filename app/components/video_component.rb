# frozen_string_literal: true

class VideoComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(video:)
    @video = video
  end

end
