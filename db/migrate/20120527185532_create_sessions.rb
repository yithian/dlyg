class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :name
      t.integer :despair
      t.integer :hope

      t.timestamps
    end
  end
end
