class AddBudgetIdToCharges < ActiveRecord::Migration[7.1]
  def change
    add_column :charges, :budget_id, :integer
  end
end
