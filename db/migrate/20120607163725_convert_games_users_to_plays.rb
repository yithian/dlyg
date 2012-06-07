class ConvertGamesUsersToPlays < ActiveRecord::Migration
  def change
    rename_table :games_users, :plays
    add_column :plays, :character_name, :string
    add_column :plays, :id, :primary_key
  end
end
