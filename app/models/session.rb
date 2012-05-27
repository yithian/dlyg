class Session < ActiveRecord::Base
  attr_accessible :despair, :hope, :name
  
  validates :despair, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :hope, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
end
