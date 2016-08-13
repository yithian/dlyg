require 'test_helper'

class PlaysControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @play = plays(:one)
  end

  test "should create play" do
    sign_in(users(:one))

    assert_difference "Play.count", +1 do
      post :create, params: {play: { game_id: games(:one), user_id: users(:one), character_id: characters(:one) }, game_id: @play.game}
    end
    assert_redirected_to game_path(games(:one))
  end

  test "shouldn't create play as random user" do
    sign_in(users(:three))
    assert_no_difference "Play.count" do
      post :create, params: {play: { game_id: games(:one), user_id: users(:three), character_id: characters(:one) }, game_id: games(:one)}
    end
    assert_redirected_to root_path, @response.message
  end

  test "shouldn't create play as nobody" do
    assert_no_difference "Play.count" do
      post :create, params: {play: { game_id: games(:one), user_id: users(:three), character_id: characters(:one) }, game_id: games(:one)}
    end
    assert_redirected_to new_user_session_path, @response.message
  end

  test "should update play as gm" do
    sign_in(users(:two))

    put :update, params: {id: @play, play: { character_id: characters(:two) }, game_id: @play.game}
    assert_redirected_to game_path(@play.game)
    assert_equal characters(:two).name, Play.find_by_id(@play.id).character.name
  end

  test "should update play as player" do
    sign_in(users(:one))

    put :update, params: {id: @play, play: { character_id: characters(:two) }, game_id: @play.game}
    assert_redirected_to game_path(@play.game)
    assert_equal characters(:two).name, Play.find_by_id(@play.id).character.name
  end

  test "shouldn't update play" do
    put :update, params: {id: @play, play: { character_id: characters(:two) }, game_id: @play.game}
    assert_redirected_to new_user_session_path, @response.message
    assert_not_equal "new name", Play.find_by_id(@play.id).character.name
  end

  test "should destroy play as gm" do
    sign_in(users(:two))

    assert_difference "Play.count", -1 do
      delete :destroy, params: {id: @play, game_id: @play.game}
    end
    assert_redirected_to game_path(@play.game)
  end

  test "should destroy play as player" do
    sign_in(users(:one))

    assert_difference "Play.count", -1 do
      delete :destroy, params: {id: @play, game_id: @play.game}
    end
    assert_redirected_to game_path(@play.game)
  end

  test "shouldn't destroy play as nobody" do
    assert_no_difference "Play.count" do
      delete :destroy, params: {id: @play, game_id: @play.game}
    end
    assert_redirected_to new_user_session_path, @response.message
  end
end
