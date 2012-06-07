class Play < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  attr_accessible :character_name, :game_id, :user_id
end
