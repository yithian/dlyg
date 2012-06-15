class RemoveCharacterNameFromPlays < ActiveRecord::Migration
  def up
    remove_column :plays, :character_name
    add_column :plays, :character_id, :integer
  end

  def down
    remove_column :plays, :character_id
    add_column :plays, :character_name, :string
  end
end
