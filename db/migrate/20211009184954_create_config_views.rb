class CreateConfigViews < ActiveRecord::Migration[6.1]
  def change
    create_table :config_views do |t|
      t.json :data
      t.string :locale,default: "uk"

      t.timestamps
    end
  end
end
