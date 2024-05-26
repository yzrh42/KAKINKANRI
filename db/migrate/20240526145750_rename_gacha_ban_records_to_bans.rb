class RenameGachaBanRecordsToBans < ActiveRecord::Migration[7.1]
  def change
    rename_table :ban, :bans
  end
end
