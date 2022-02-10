class Dish < ApplicationRecord
  has_one_attached :image

  belongs_to :category

  has_many :dish_variants
  has_many :variants, through: :dish_variants

  scope :delivered, ->{where(is_delivered: true)}
  scope :published, ->{where(is_published: true)}

  def set_image=(src)
    file = URI.parse(src).open
    image.attach(io: file, filename: name)
  rescue OpenURI::HTTPError => e
    pp e
  end

  def dish_image(width= 200,height=200)
    if image.attached?
      image.variant(resize_to_limit: [width,height])
    else
      '/bash.svg'
    end
  end
end
