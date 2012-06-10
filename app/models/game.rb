# Game is the major building block of Dlyg. It has attributes
# for players (and the connections between players and the game)
# and for dice results. This is also where rolling dice occurs.

class Game < ActiveRecord::Base
  belongs_to :gm, :class_name => "User"
  has_many :plays
  has_many :players, :through => :plays, :source => :user, :uniq => true
  has_many :results, :dependent => :destroy, :order => "created_at ASC"
  
  attr_accessible :despair, :hope, :name, :gm_id
  
  validates :despair, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :hope, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  
  # roll dem bones
  # returns degree, the winner, the dominating pool and results for discipline,
  # exhaustion, madness and pain pools
  def roll(discipline_dice = 0, exhaustion_dice = 0, madness_dice = 0, pain_dice = 0, char_name = 'player')
    # in case an empty name is passed
    char_name = 'player' if char_name.nil? or char_name.empty?
    
    # roll dice
    pool = DiceRoller::DicePool.new(0, discipline_dice)
    discipline = pool.roll_pool.six_result.sort.reverse
    
    pool.num_six = exhaustion_dice
    exhaustion = pool.roll_pool.six_result.sort.reverse
    
    pool.num_six = madness_dice
    madness = pool.roll_pool.six_result.sort.reverse
    
    pool.num_six = pain_dice
    pain = pool.roll_pool.six_result.sort.reverse
    
    # create a new result and save it
    discipline = discipline.join(', ')
    exhaustion = exhaustion.join(', ')
    madness = madness.join(', ')
    pain = pain.join(', ')
    
    result = Result.create(:game_id => self.id, :discipline => discipline.to_s, :exhaustion => exhaustion.to_s, :madness => madness.to_s, :pain => pain.to_s)
    result.determine!(char_name)
        
    # bump despair count if pain is dominant
    if result.dominating == :pain
      self.despair += 1
    end
    
    self.save!
    self.results << result
    while self.results.length > 5
      self.results.delete(self.results.first)
    end
    
    return result
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
  
  # show game name in url
  def to_param
    "#{self.id}_#{self.name.gsub(/[ '"#%\{\}|\\^~\[\]`]/, '-').gsub(/[.&?\/:;=@]/, '')}"    
  end
end
