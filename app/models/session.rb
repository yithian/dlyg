class Session < ActiveRecord::Base
  attr_accessible :despair, :hope, :name
  
  validates :despair, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :hope, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  
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
