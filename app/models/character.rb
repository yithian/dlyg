class Character < ActiveRecord::Base
  belongs_to :game
  belongs_to :player, :class_name => "User"

  attr_accessible :beneath, :concept, :discipline, :e_talent, :exhaustion, :just_happened, :keeping_awake, :m_talent, :madness, :name, :path, :surface
  attr_reader :player_id, :game_id

  validates :name, :unique_in_game => true
  validates :discipline, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3}
  validates :exhaustion, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 6}
  validates :madness, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3}, :balances_discipline => true
end
