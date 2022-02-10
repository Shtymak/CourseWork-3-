ActiveAdmin.register ConfigView do
  menu parent: "Системні налаштування"

  permit_params :data, :locale

  filter :updated_at

  actions :configure, :index, :show

  controller do
    def edit_configure
      @config = ConfigView.find(params[:id])
    end

    def change
      @config = ConfigView.find(params[:id])
      params.each do |key, value|
        @config.data[key] = value if @config.data.key?(key)
        if value.instance_of?(ActionDispatch::Http::UploadedFile)
          eval "@config.#{key} = value"
        end
      end
      @config.save!
      redirect_to admin_config_view_url(@config)
    end
  end

  action_item :edit_configure, only: :show do
    link_to 'Edit configure', :admin_config_views_edit_configure_path
  end
  show do |main_config|
    attributes_table do
      row :locale
      main_config.data.keys.each do |key|
        eval "row :#{key} do
          main_config.data[key]
        end"
      end
    end
  end

  index do |config|
    actions
    column :locale do |s|
      link_to s.locale, admin_config_view_path(s)
    end
    column :updated_at
  end

end
