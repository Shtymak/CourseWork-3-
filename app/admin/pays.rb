ActiveAdmin.register Pay do
  
  show do
    attributes_table do
      row :sum
      row :client_id
      row :status
      row :details
      row (:order_id){|pay| Order.find(pay.order_id)}
    end
  end

end
