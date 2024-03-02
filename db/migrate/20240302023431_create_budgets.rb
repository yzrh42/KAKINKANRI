class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.integer :year, null: false
      t.integer :month, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
