class AddGroupToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :group_id, :integer
  end
end
