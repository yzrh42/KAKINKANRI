class AddUserIdToBudgets < ActiveRecord::Migration[7.1]
  def change
    add_column :budgets, :user_id, :integer
  end
end
