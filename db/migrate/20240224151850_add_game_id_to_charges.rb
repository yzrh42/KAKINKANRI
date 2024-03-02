class AddGameIdToCharges < ActiveRecord::Migration[7.1]
  def change
    add_column :charges, :game_id, :integer, null: false
    add_index :charges, :game_id
  end
end
