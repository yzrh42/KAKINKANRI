class AddCurrentToStones < ActiveRecord::Migration[7.1]
  def change
    add_column :stones, :current, :integer
  end
end
