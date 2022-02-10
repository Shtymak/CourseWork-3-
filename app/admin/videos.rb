ActiveAdmin.register Video do
  menu parent: "Мультимедіа"

  permit_params :full_url, :title, :title_en, :description, :description_en

  form do |f|
    f.inputs do
      f.input :full_url
      f.input :title
      f.input :title_en
      f.input :description,as: :text
      f.input :description_en,as: :text
    end
    f.actions
  end

  show do
      attributes_table do
        row :url
        row :title
        row :title_en
        row :description
        row :description_en
      end
    end

end
