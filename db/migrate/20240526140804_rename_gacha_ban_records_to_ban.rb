class RenameGachaBanRecordsToBan < ActiveRecord::Migration[7.1]
  def change
    rename_table :gacha_ban_records, :ban
  end
end
