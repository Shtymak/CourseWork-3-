ActiveAdmin.register Order do
  menu parent: "Замовлення"

  permit_params :user_name, :user_id, :address, :longitude, :latitude, :self_pickup, :payment_id, :state, :description, :promo_code_id, :phone, :delivery_date, :delivery_time, :delivery_sum, :payment_type

  filter :user_name
  filter :address
  filter :self_pickup
  filter :state
  filter :payment_type
  filter :promo_code_id
  filter :delivery_at
  filter :delivery_sum
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :user_name
    column :address
    column :self_pickup
    column :state
    column :payment_type
    column :promo_code_id
    column :delivery_at
    column :delivery_sum
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user_name
      f.input :address
      f.input :self_pickup, include_blank: false
      f.input :state, include_blank: false
      f.input :payment_type, include_blank: false
      f.input :payment_id
      f.input :description
      f.input :promo_code_id
      f.date_field :delivery_at
      f.input :delivery_sum
    end
    f.actions
  end

  show do |order|
    order.update(state: 2) if Order.states[order.state] == 0
    attributes_table do
      row :user_name
      row :address
      row :self_pickup
      row :payment_type
      row :state
      row :payment_id
      row :description
      row :delivery_at
      row :delivery_sum

      panel 'Страви' do
        table_for order.order_dishes do
          column "Cтрава", :dish
          column "Ціна", :price do |order|
            order.dish.price
          end
          column "Кількість", :count
          column "Варінат", :variant do |order|
            order.variant_name
          end
          column "Загальна сума", :sum_price do |order|
            order.dish.price * order.count
          end
          column :sum_price do |order|
            order.dish.price * order.count
          end
        end
      end
    end
  end
end
