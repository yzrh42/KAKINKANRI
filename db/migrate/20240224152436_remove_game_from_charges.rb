class RemoveGameFromCharges < ActiveRecord::Migration[7.1]
  def change
    remove_column :charges, :game, :string
  end
end
