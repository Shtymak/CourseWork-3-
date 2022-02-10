module FlashHelper

  def flash_block(text, type = 'success')
    flash.now[type] = text
  end

end
