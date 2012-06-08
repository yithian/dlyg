# represents the result of a dice roll for Don't Rest Your Head.

class Result < ActiveRecord::Base
  belongs_to :game
  
  attr_accessible :game_id, :degree, :discipline, :exhaustion, :madness, :pain, :winner, :dominating
end
