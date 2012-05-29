class AddGmToGames < ActiveRecord::Migration
  def change
    add_column :games, :gm, :integer, :options => "CONSTRAINT fk_characters_users references user(id)"
  end
end
