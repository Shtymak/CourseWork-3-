ActiveAdmin.register Group do
  menu parent: "Системні налаштування"

  permit_params :name, :name_en, :photo

  filter :name
  filter :name_en

  form do |f|
    f.inputs do
      f.input :name
      f.input :name_en
      f.input :photo, as: :file
    end
   f.actions
  end

  show do
    attributes_table do
      row :name
      row :name_en
      row (:photo ){|group| image_tag group.image, height: 200}
    end
    panel 'Категорії' do
      table_for group.categories do
        column :name do  |category|
          link_to category.name, admin_category_path(category)
        end
        column :name_en
      end
    end
  end

end
