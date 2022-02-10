ActiveAdmin.register Image do
  menu parent: "Мультимедіа"

  permit_params :photo

  includes :blob

  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column "Image" do |image|
      image_tag image.photo, height: 50, width: 50
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :photo, as: :file,required: true
    end
    f.actions
  end

  show do
    attributes_table do
      row :photo do |image|
        image_tag image.photo
      end
    end
  end
  
end
