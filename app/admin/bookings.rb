ActiveAdmin.register Booking do
  menu parent: "Замовлення"

  permit_params :user_name, :user_id, :select_at, :person_count, :description, :phone

  show do |booking|
    attributes_table do
      row :user
      row :select_at
      row (:person_count){|booking| booking.person_count >= 10? "10+" : booking.person_count >= 5?"5-9":booking.person_count}
      row (:phone){User.find(booking.user_id).phone}
      row :description
    end
  end

end
