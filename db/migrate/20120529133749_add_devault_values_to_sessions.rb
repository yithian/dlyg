class AddDevaultValuesToSessions < ActiveRecord::Migration
  def change
    change_column :sessions, :despair, :integer, :default => 0, :null => false
    change_column :sessions, :hope, :integer, :default => 0, :null => false
  end
end
