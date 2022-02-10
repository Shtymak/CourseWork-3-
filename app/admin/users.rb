ActiveAdmin.register User do
  permit_params :user_name, :phone, :user_description

  filter :user_name
  filter :phone
  filter :user_description
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :user_name
      row :phone
      panel 'Замовлення' do
        table_for user.orders do |order|
          column :id do
            link_to order.id, admin_order_path(order)
          end
        end
      end
      panel 'ПРОМОКОДИ' do
        table_for user.promocodes  do
          column :pcomocodes do |user|
            PromoCode.where(id: user.id)
          end
        end
      end
    end
  end

end
