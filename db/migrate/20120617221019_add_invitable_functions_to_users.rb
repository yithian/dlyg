class AddInvitableFunctionsToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
        t.string   :invitation_token, :limit => 60
        t.datetime :invitation_sent_at
        t.datetime :invitation_accepted_at
        t.integer  :invitation_limit
        t.integer  :invited_by_id
        t.string   :invited_by_type

    end

    # Allow null encrypted_password
    change_column :users, :encrypted_password, :string, :null => true
  end
  
  def down
    remove_column :users, :invitation_token
    remove_column :users, :invitation_sent_at
    remove_column :users, :invitation_accepted_at
    remove_column :users, :invitation_limit
    remove_column :users, :invited_by_id
    remove_column :users, :invited_by_type
  end
end
