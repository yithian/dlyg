require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  setup do
    @character = characters(:one)
  end

  test "should show character" do
    get :show, id: @character, game_id: @character.game
    assert_response :success
  end

  test "shouldn't get edit as another user" do
    get :edit, id: @character, game_id: @character.game
    assert_redirected_to new_user_session_path, response.message
  end

  test "should get edit as player" do
    sign_in(users(:one))

    get :edit, id: @character, game_id: @character.game
    assert_response :success
  end

  test "should get edit as gm" do
    sign_in(users(:two))

    get :edit, id: @character, game_id: @character.game
    assert_response :success
  end

  test "shouldn't update character" do
    put :update, id: @character, game_id: @character.game, character: { beneath: @character.beneath, concept: @character.concept, discipline: @character.discipline, e_talent: @character.e_talent, exhaustion: @character.exhaustion, just_happened: @character.just_happened, keeping_awake: @character.keeping_awake, m_talent: @character.m_talent, madness: @character.madness, name: @character.name, path: @character.path, surface: @character.surface, fight: 2, flight: 1 }
    @character = Character.find(characters(:one).id)
    
    assert_redirected_to new_user_session_path
    assert_not_equal 2, @character.fight
    assert_not_equal 1, @character.flight
  end

  test "should update character as player" do
    sign_in(users(:one))

    put :update, id: @character, game_id: @character.game, character: { beneath: @character.beneath, concept: @character.concept, discipline: @character.discipline, e_talent: @character.e_talent, exhaustion: @character.exhaustion, just_happened: @character.just_happened, keeping_awake: @character.keeping_awake, m_talent: @character.m_talent, madness: @character.madness, name: @character.name, path: @character.path, surface: @character.surface, fight: 2, flight: 1 }
    @character = Character.find(characters(:one).id)
    
    assert_redirected_to game_character_path(@character.game, @character)
    assert_equal(2, @character.fight)
    assert_equal(1, @character.flight)
  end

  test "should update character as gm" do
    sign_in(users(:two))

    put :update, id: @character, game_id: @character.game, character: { beneath: @character.beneath, concept: @character.concept, discipline: @character.discipline, e_talent: @character.e_talent, exhaustion: @character.exhaustion, just_happened: @character.just_happened, keeping_awake: @character.keeping_awake, m_talent: @character.m_talent, madness: @character.madness, name: @character.name, path: @character.path, surface: @character.surface, fight: @character.fight, flight: @character.flight }
    assert_redirected_to game_character_path(@character.game, @character)
  end
end
