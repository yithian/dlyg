# represents a character sheet

class Character < ActiveRecord::Base
  belongs_to :game
  belongs_to :player, :class_name => "User"

  validates :discipline, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3}
  validates :exhaustion, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 6}
  validates :madness, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3}, :balances_discipline => true

  # show game name in url
  def to_param
    name = self.name || ''
    "#{self.id}_#{name.gsub(/[ '"#%\{\}|\\^~\[\]`]/, '-').gsub(/[.&?\/:;=@]/, '')}"
  end
end
