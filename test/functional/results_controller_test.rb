require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @result = results(:one)
  end

  test 'should recall a scar as GM' do
    sign_in(users(:one))

    orig_win = @result.winner
    orig_dom = @result.dominating
    orig_pain = @result.pain
    orig_despair = @result.game.despair

    # puts @result.pain
    @result.pain = ''
    @result.save!

    put :recall, xhr: true, params: {id: @result, pool: 'discipline', game_id: @result.game}
    @result = Result.find(@result.id)

    assert_not_equal orig_win, @result.winner, "winner was not recalculated"
    assert_not_equal orig_dom, @result.dominating, "dominating was not recalculated"
    assert_not_equal orig_pain, @result.pain, "pain was not saved"
    assert_not_equal orig_despair, @result.game.despair, "despair was not recalculated"
  end

  test 'should recall a scar as player' do
    sign_in(users(:two))

    orig_win = @result.winner
    orig_dom = @result.dominating
    orig_pain = @result.pain
    orig_despair = @result.game.despair

    # puts @result.pain
    @result.pain = ''
    @result.save!

    put :recall, xhr: true, params: {id: @result, pool: 'discipline', game_id: @result.game}
    @result = Result.find(@result.id)

    assert_not_equal orig_win, @result.winner, "winner was not recalculated"
    assert_not_equal orig_dom, @result.dominating, "dominating was not recalculated"
    assert_not_equal orig_pain, @result.pain, "pain was not saved"
    assert_not_equal orig_despair, @result.game.despair, "despair was not recalculated"

  end

  test "shouldn't recall a scar as another user" do
    orig_win = @result.winner
    orig_dom = @result.dominating
    orig_pain = @result.pain
    orig_despair = @result.game.despair

    # puts @result.pain
    @result.pain = ''
    @result.save!

    put :recall, xhr: true, params: {id: @result, pool: 'discipline', game_id: @result.game}
    @result = Result.find(@result.id)

    assert_equal orig_win, @result.winner, "winner was recalculated"
    assert_equal orig_dom, @result.dominating, "dominating was recalculated"
    assert_equal orig_despair, @result.game.despair, "despair was recalculated"
  end

  test "should destroy result" do
    sign_in(users(:one))
    game = @result.game

    assert_difference('Result.count', -1) do
      delete :destroy, params: {id: @result, game_id: @result.game}
    end

    assert_redirected_to game_path(game)
  end

  test "shouldn't destroy result" do
    assert_no_difference "Result.count" do
      delete :destroy, params: {id: @result, game_id: @result.game}
    end

    sign_in(users(:two))

    assert_no_difference "Result.count" do
      delete :destroy, params: {id: @result, game_id: @result.game}
    end
  end
end
