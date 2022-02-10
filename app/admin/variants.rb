ActiveAdmin.register Variant do
  menu parent: "Системні налаштування"

   permit_params :name,:name_en

   filter :name
   filter :name_en

end
