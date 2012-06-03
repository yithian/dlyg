class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :game_id
      t.string :winner
      t.integer :degree
      t.string :discipline
      t.string :exhaustion
      t.string :madness
      t.string :pain

      t.timestamps
    end
  end
end
