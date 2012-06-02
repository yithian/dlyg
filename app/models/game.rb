class Game < ActiveRecord::Base
  belongs_to :gm, :class_name => "User"
  has_and_belongs_to_many :players, :class_name => "User"
  
  attr_accessible :despair, :hope, :name, :gm_id
  
  validates :despair, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :hope, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  
  # roll dem bones
  # returns degree, the winner, the dominating pool and results for discipline,
  # exhaustion, madness and pain pools
  def roll(discipline_dice = 0, exhaustion_dice = 0, madness_dice = 0, pain_dice = 0)
    degree = 0
    discipline_degree = 0
    exhaustion_degree = 0
    madness_degree = 0
    pain_degree = 0
    
    # count degree of player pools
    pool = DiceRoller::DicePool.new(0, discipline_dice)
    discipline = pool.roll_pool.six_result.sort.reverse

    discipline.each do |d|
      if d <= 3
        degree += 1
        discipline_degree += 1
      end
    end
    
    pool.num_six = exhaustion_dice
    exhaustion = pool.roll_pool.six_result.sort.reverse
    
    exhaustion.each do |e|
      if e <= 3
        degree += 1
        exhaustion_degree += 1
      end
    end
    
    pool.num_six = madness_dice
    madness = pool.roll_pool.six_result.sort.reverse
    
    madness.each do |m|
      if m <= 3
        degree += 1
        madness_degree += 1
      end
    end
    
    # count degree of pain
    pool.num_six = pain_dice
    pain = pool.roll_pool.six_result.sort.reverse
    
    pain.each do |p|
      if p <= 3
        pain_degree += 1
      end
    end
    
    # determine who wins
    if degree >= pain_degree
      wins = :player
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
    
    # bump despair count if pain is dominant
    if dominating == :pain
      self.despair += 1
    end
    
    return degree, wins, dominating, discipline, exhaustion, madness, pain
  end
  
  # handle the caluclations for casting a shadow
  def cast_shadow(coins = 1)
    self.despair -= coins
    self.hope += coins
  end
  
  # handle the caluclations for shedding light
  def shed_light(coins = 1)
    self.hope -= coins
  end
end
