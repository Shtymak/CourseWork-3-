Rails.application.routes.draw do
  scope '/(:locale)', locale: /#{I18n.available_locales.join("|")}/ do

    root to: "pages#index"
    get 'about', to: "pages#about"
    get 'menu',to:"menu#index", as: "menu"
    get 'deliveries', to: "deliveries#index"

    resources :orders,only:[:create] do
      member do
        post :callback
        get :pay
      end
    end

    resources :bookings,only:[:new,:create]

    resources :dishes,only: [] do
      member do
        post :add_to_cart
        delete :remove_from_cart
      end
      collection do
        get :cart
      end
    end

    get "cart",to:"carts#show"
    delete "cart/clear_cart",to:"carts#clear_cart"
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '/admin/config_views/:id/edit_configure', to: 'admin/config_views#edit_configure', as: :admin_config_views_edit_configure_path
  post '/admin/config_views/:id/change', to: 'admin/config_views#change', as: :admin_config_views_change
end
