module ActsToMenu
  extend ActiveSupport::Concern

  included do
    before_action :categories, only: [:index]
    before_action :groups, only: [:index]
    before_action :all_categories, only: [:index]
  end

  private

  def categories
    @categories ||= Category.without_group.with_attached_photo
  end

  def groups
    @groups ||= Group.all.includes(:categories)
  end

  def all_categories
    @all_categories ||= Category.all
  end
end
