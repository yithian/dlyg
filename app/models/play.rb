# The name play is used in the sense of "I play in a game".
# This class represents this association.
#
# A join table is used in lieu of a has_and_belongs_to_many
# approach because a character name cannot be included in a
# habtm join table.

class Play < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :character, :dependent => :destroy

  attr_accessible :character_id, :game_id, :user_id
  
  validates :game_id, :presence => true
  validates :user_id, :presence => true
  validates :character_id, :presence => true
end
