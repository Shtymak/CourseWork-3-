ActiveAdmin.register Dish do
   permit_params :name,:name_en, :weight , :price,  :category_id, :description, :description_en, :is_published, :is_delivered, :is_active_from_delivered, :image, variant_ids:[]

   includes :category

   filter :name
   filter :name_en
   filter :category
   filter :price
   filter :is_published
   filter :is_delivered
   filter :is_active_from_delivered
   filter :updated_at
   filter :created_at

     form do |f|
       f.inputs do
         f.input :name
         f.input :name_en
         f.input :variants, as: :check_boxes
         f.input :image, as: :file
         f.input :description, as: :text
         f.input :description_en, as: :text
         f.input :price
         f.input :weight
         f.input :category, collection: Category.all
         f.input :is_published
         f.input :is_delivered
         f.input :is_active_from_delivered
       end
       f.actions
     end
     show do
         attributes_table do
           row :name
           row :name_en
           row :description,as: :text
           row :description_en,as: :text
           row :image do |object|
             image_tag object.dish_image, width:250
           end
          row :dish_variants do |dish|
             dish.variants
          end
           row :price
           row :weight
           row :category do |dish|
              dish.category
           end
           row :is_published
           row :is_delivered
           row :is_active_from_delivered
       end
     end

     index do
       selectable_column
       id_column
       column :name
       column :name_en
       column :price
       column :category
       column :weight
       column :is_published
       column :is_delivered
       column :is_active_from_delivered
       column :updated_at

       column :created_at
       actions
     end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :category_id, :description, :is_published, :is_delivered, :is_active_from_delivered]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
