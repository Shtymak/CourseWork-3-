class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.string :message
      t.string :params
      t.string :backtraces
      t.string :referer
      t.string :user_agent

      t.timestamps
    end
  end
end
