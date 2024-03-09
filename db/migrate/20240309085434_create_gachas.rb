class CreateGachas < ActiveRecord::Migration[7.1]
  def change
    create_table :gachas do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :amount
      t.integer :number
      t.datetime :date, null: false
      t.string :image
      t.text :memo
      t.timestamps
    end
  end
end
