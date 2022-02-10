module ActsAsDefaultImage
  extend ActiveSupport::Concern

  included do
    has_one_attached :photo
  end
  
  def image
    if photo.attached?
      photo
    else
      '/empty_category.svg'
    end
  end
end
