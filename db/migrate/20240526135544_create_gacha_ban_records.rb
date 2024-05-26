class CreateGachaBanRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :gacha_ban_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.datetime :start_date
      t.integer :ban_days

      t.timestamps
    end
  end
end
