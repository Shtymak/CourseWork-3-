ActiveAdmin.register Log do
  menu parent: "Адміністрування"

  show do
    attributes_table do
      row :message
      row :params
      row :user_agent
      row :referer
      row :created_at
      row :backtraces do
        raw logs_error.backtraces
      end
    end
  end

  index do
    selectable_column
    id_column
    column :message
    column :params
    column :user_agent
    column :referer
    column :created_at
    actions
  end
end
