class AddDefaultValuesToCharacters < ActiveRecord::Migration
  def change
    change_column_default :characters, :discipline, 3
    change_column_default :characters, :exhaustion, 0
    change_column_default :characters, :madness, 0
  end
end
