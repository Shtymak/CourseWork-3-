class AddSequenceNumberToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :sequence_number, :integer
  end
end
