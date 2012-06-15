require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  def setup
    @character = characters(:one)
  end

  test "discipline and madness equal 3" do
    @character.discipline = 1
    @character.madness = 1

    assert ! @character.save, "character was saved with invalid dice pools"
  end

  test "pools are positive" do
    @character.discipline = -1
    @character.madness = 3
    assert ! @character.save, "character was saved with negative discipline"

    @character.discipline = 3
    @character.madness = -1
    assert ! @character.save, "character was saved with negative madness"

    @character.discipline = 3
    @character.exhaustion = -1
    @character.madness = 0
    assert ! @character.save, "character was saved with negative exhaustion"
  end

  test "should save normally" do
    @character.discipline = 2
    @character.exhaustion = 3
    @character.madness = 1

    assert @character.save, "character could not be saved normally"
  end
end
