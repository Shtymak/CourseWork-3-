class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :url
      t.string :title, default: "", null:false
      t.string :title_en, default: "", null:false
      t.string :description, default: "", null:false
      t.string :description_en, default: "", null:false

      t.timestamps
    end
  end
end
