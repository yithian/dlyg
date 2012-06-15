class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :game_id
      t.integer :player_id
      t.string :name
      t.string :concept
      t.text :keeping_awake
      t.text :just_happened
      t.text :surface
      t.text :beneath
      t.text :path
      t.integer :discipline
      t.integer :exhaustion
      t.integer :madness
      t.text :e_talent
      t.text :m_talent

      t.timestamps
    end
  end
end
