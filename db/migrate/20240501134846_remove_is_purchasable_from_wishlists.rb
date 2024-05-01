class RemoveIsPurchasableFromWishlists < ActiveRecord::Migration[7.1]
  def change
    remove_column :wishlists, :is_purchasable, :boolean
  end
end
