class RenameGmToGmIdInGames < ActiveRecord::Migration
  def change
    rename_column :games, :gm, :gm_id
  end
end
