class CreateWishlists < ActiveRecord::Migration[7.1]
  def change
    create_table :wishlists do |t|
      t.string :name
      t.integer :price
      t.boolean :is_purchasable
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
