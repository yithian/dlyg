# represents the result of a dice roll for Don't Rest Your Head.

class Result < ActiveRecord::Base
  belongs_to :game
  
  attr_accessible :game_id, :degree, :discipline, :exhaustion, :madness, :pain, :winner, :dominating
  
  # counts successes and determines a winner
  def determine!(char_name = 'player')
    degree = 0
    pain_degree = 0
    
    # count successes for player pools
    self.discipline.split(', ').each do |n|
      n = n.to_i
      
      degree += 1 if n <= 3
    end
    
    self.exhaustion.split(', ').each do |n|
      n = n.to_i
      
      degree += 1 if n <= 3
    end
    
    self.madness.split(', ').each do |n|
      n = n.to_i
      
      degree += 1 if n <= 3
    end
    
    self.pain.split(', ').each do |n|
      n = n.to_i
      
      pain_degree += 1 if n <= 3
    end
    
    # determine who wins
    if degree >= pain_degree
      wins = char_name
    else
      wins = :pain
      degree = pain_degree
    end
    
    # determine which pool is dominant
    # there is some trickery here: the order of assignment is important.
    # due to the hierarchy of tie-breakers, "tied" elements assigned later
    # in the hash will overwrite earlier elements. so later elements
    # "beat" earlier ones
    dominant = {pain => :pain, exhaustion => :exhaustion, madness => :madness, discipline => :discipline }
    
    dominating = dominant[dominant.keys.max]
    
    self.winner = wins
    self.degree = degree
    self.discipline = discipline
    self.exhaustion = exhaustion
    self.madness = madness
    self.pain = pain
    self.dominating = dominating
    self.save
  end
end
