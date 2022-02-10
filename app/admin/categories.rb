ActiveAdmin.register Category do
  menu parent: 'Системні налаштування'

  permit_params :name, :name_en, :photo, :sequence_number, :group_id

  includes :group, :photo_attachment

  filter :name
  filter :name_en
  filter :group

  form do |f|
    f.inputs do
      f.input :name
      f.input :name_en
      f.input :group, collection: Group.all
      f.input :photo, as: :file
      f.input :sequence_number
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :name_en
      row :group
      row :sequence_number
      row(:photo) { |category| image_tag category.image, height: 200 }
    end
    panel 'Страви' do
      table_for category.dishes do
        column :name do |dish|
          link_to dish.name, admin_dish_path(dish)
        end
        column :name_en
        column :price
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :name_en
    column :group do |category|
      link_to category.group.name, admin_group_path(category.group) if category.group
    end
    column :sequence_number
    column 'Image' do |category|
      image_tag category.image, height: 50, width: 50
    end
    column :created_at
    column :updated_at
    actions
  end
end
