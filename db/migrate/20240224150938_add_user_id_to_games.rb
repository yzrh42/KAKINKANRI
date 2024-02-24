class AddUserIdToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :user_id, :integer, null: false
    add_index :games, :user_id
  end
end
