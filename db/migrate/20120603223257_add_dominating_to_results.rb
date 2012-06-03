class AddDominatingToResults < ActiveRecord::Migration
  def change
    add_column :results, :dominating, :string
  end
end
