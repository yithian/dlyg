# represents a character sheet

class Character < ActiveRecord::Base
  belongs_to :game
  belongs_to :player, :class_name => "User"

  attr_accessible :beneath, :concept, :discipline, :e_talent, :exhaustion, :just_happened, :keeping_awake, :m_talent, :madness, :name, :path, :surface, :player_id, :game_id, :fight, :flight

  validates :discipline, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3}
  validates :exhaustion, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 6}
  validates :madness, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3}, :balances_discipline => true
  
  # show game name in url
  def to_param
    name = self.name || ''
    "#{self.id}_#{name.gsub(/[ '"#%\{\}|\\^~\[\]`]/, '-').gsub(/[.&?\/:;=@]/, '')}"    
  end
end
