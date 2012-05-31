require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    @game = games(:one)
  end
  
  # test that attributes can be read
  test "can access attributes" do
    assert_equal(games(:one).name, @game.name)
    assert_equal(games(:one).hope, @game.hope)
    assert_equal(games(:one).despair, @game.despair)    
  end
  
  # test that attributes can be written to and saved
  test "can write to attributes" do
    @game.name = "hurf"
    @game.hope = 100
    @game.despair = 200
    
    assert @game.save!, "game didn't save"
    
    @game = Game.find_by_id(games(:one).id)
    
    assert_equal("hurf", @game.name)
    assert_equal(100, @game.hope)
    assert_equal(200, @game.despair)
  end
  
  # assure that hope and despair validations work
  test "validations" do
    # only integers
    @game.hope = 1.2
    assert (not @game.save), "saved a float to an integer-only value"
    @game.hope = 1
    
    # only positive integers
    @game.despair = -1
    assert (not @game.save), "saved a negative number"
  end
  
  # assure that when pain dominates, it adds a despair coin
  test "pain dominates" do
    assert_difference "@game.despair", +1 do
      @game.roll(0, 0, 0, 1)
    end
  end
  
  # casting a shadow should adjust coins
  test "casting a shadow" do
    @game.cast_shadow(1)
    
    assert_equal(0, @game.despair)
    assert_equal(2, @game.hope)
  end
  
  # shedding light should adjust coins
  test "shedding light" do
    assert_difference "@game.hope", -1 do
      @game.shed_light(1)
    end
  end
end
