module ApplicationHelper
  def get_locale
    (I18n.locale || I18n.default_locale).to_s
  end

  def main_translate(object,field)
    if I18n.locale == I18n.default_locale || (translate= object.send("#{field}_#{I18n.locale.to_s}")).blank?
      object.send(field)
    else
      translate
    end
  end

  def breadcrumbs(add_links=[["menu",menu_path]],links:[["home",root_path]])
    last_link = add_links.pop
    content_tag(
      :div,
      ((links+add_links).map do |name,link|
        link_to(t("breadcrumbs.#{name.downcase}"),link)
      end+[t("breadcrumbs.#{last_link.first}")]).join(" / ").html_safe,
    class: "pb-4 breadcrumbs"
    )
  end
end
