class Result < ActiveRecord::Base
  belongs_to :game
  
  attr_accessible :game_id, :degree, :discipline, :exhaustion, :madness, :pain, :winner
end
