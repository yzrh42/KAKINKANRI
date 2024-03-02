class CreateCharges < ActiveRecord::Migration[7.1]
  def change
    create_table :charges do |t|
      t.integer :user_id, null: false
      t.string :game, null: false
      t.integer :amount, null: false
      t.datetime :date, null: false
      t.string :image
      t.text :memo

      t.timestamps
    end
    add_foreign_key :charges, :users
  end
end