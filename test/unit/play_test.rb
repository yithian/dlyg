require 'test_helper'

class PlayTest < ActiveSupport::TestCase
  def setup
    @play = plays(:one)
  end
  
  test "can access attribures" do
    assert @play.user_id = users(:one).id
    assert @play.game_id = games(:one).id
    assert @play.character_name = "a name"
    assert @play.save
    @play = Play.find_by_id(plays(:one))
    
    assert_equal users(:one).id, @play.user_id
    assert_equal games(:one), @play.game
    assert_equal "a name", @play.character_name
  end
  
  test "shouldn't save without foreign keys" do
    assert_no_difference "Play.count" do
      Play.create(:game_id => games(:one))
    end
    
    assert_no_difference "Play.count" do
      Play.create(:user_id => users(:one))
    end
  end
end
