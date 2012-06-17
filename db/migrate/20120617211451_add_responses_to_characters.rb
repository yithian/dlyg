class AddResponsesToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :fight, :integer, :default => '0'
    add_column :characters, :flight, :integer, :default => '0'
    
    Character.update_all('fight = 0', 'fight IS NULL')
    Character.update_all('flight = 0', 'flight IS NULL')
  end
end
