class Video < ApplicationRecord

  def full_url=(_url)
    update(url: _url.split('/').last)
  end

  def full_url
    url
  end
end
