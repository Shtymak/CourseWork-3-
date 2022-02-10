class PagesController < ApplicationController
  def index
    @videos = Video.all
    @images = Image.all
  end
end
