class AddColumnPositionToWishlists < ActiveRecord::Migration[7.1]
  def change
    add_column :wishlists, :position, :integer
  end
end
