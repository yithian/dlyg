class RenameSessionsToGames < ActiveRecord::Migration
  def change
    rename_table :sessions, :games
  end
end
