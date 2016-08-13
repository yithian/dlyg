require 'test_helper'

class PlayTest < ActiveSupport::TestCase
  def setup
    @play = plays(:one)
  end

  test 'can access attributes' do
    assert @play.user_id = users(:one).id
    assert @play.game_id = games(:one).id
    assert @play.character_id = characters(:one).id
    assert @play.save
    @play = Play.find_by_id(plays(:one).id)

    assert_equal users(:one).id, @play.user.id
    assert_equal games(:one), @play.game
    assert_equal characters(:one), @play.character
  end

  test "shouldn't save without foreign keys" do
    assert_no_difference "Play.count" do
      Play.create(:game_id => games(:one).id)
    end

    assert_no_difference "Play.count" do
      Play.create(:user_id => users(:one).id)
    end
  end
end
