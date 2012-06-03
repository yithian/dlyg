require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  def setup
    @result = results(:one)
  end
  
  test "access attributes" do
    assert @result.game_id, "couldn't access game_id"
    assert @result.winner, "couldn't access winner"
    assert @result.degree, "couldn't access degree"
    assert @result.discipline, "couldn't access discipline"
    assert @result.exhaustion, "couldn't access exhaustion"
    assert @result.madness, "couldn't access madness"
    assert @result.madness, "couldn't access madness"
  end
end
