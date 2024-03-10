class CreateStones < ActiveRecord::Migration[7.1]
  def change
    create_table :stones do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :goal, null: false
      t.integer :login
      t.integer :daily
      t.integer :price
      t.timestamps
    end
  end
end
