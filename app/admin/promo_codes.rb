ActiveAdmin.register PromoCode do
   permit_params :code, :valid_until, :user_id, :is_activated

  index do
    selectable_column
    id_column
    column :code
    column :is_activated
    column :valid_until
    column "User" do |code|
        link_to  User.find_by(id: code.user_id).user_name, admin_user_path(User.find_by(id: code.user_id)) if code.user_id
    end
    actions
  end

  show do
    attributes_table do
      row :code
      row :is_activated
      row :valid_until
      row :user do |code|
        link_to  User.find_by(id: code.user_id).user_name, admin_user_path(User.find_by(id: code.user_id)) if code.user_id
      end
    end
  end


end
