require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  # anyone should be able to get the index
  test "should get index as nobody" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  # only owners should see edit and delete icons
  test "should get index as gm" do
    sign_in(users(:one))

    get :index
    assert_response :success
    assert_not_nil assigns(:games)

    # assure there's a row containing the gm-ed game with icons
    assert /td.*href.*img.*\n.*MyString.*\n.*td.*href/.match(@response.body), "didn't display image for gm-ed game"
  end

  test "should get new" do
    sign_in(users(:one))

    get :new
    assert_response :success

    # hope and despair should only be present on the edit form
    assert ! /despair/.match(@response.body)
    assert ! /hope/.match(@response.body)
    # same with the players list
    assert ! /Players/.match(@response.body)
  end

  test "shouldn't get new" do
      get :new
      assert_redirected_to new_user_session_path, @response.message
  end

  test "should create game" do
    sign_in(users(:one))

    assert_difference('Game.count') do
      post :create, game: { name: "new game" }
    end

    assert_redirected_to game_path(assigns(:game))
    assert Game.find_by_name("new game")
  end

  test "shouldn't create game" do
    assert_no_difference('Game.count') do
      post :create, game: { name: @game.name }
    end

    assert_redirected_to new_user_session_path, @response.message
  end

  test "should show game as anybody" do
    get :show, id: @game
    assert_response :success

    assert_select "input[value='Roll dice']", false
    assert_select "input[value='cast a shadow']", false
    assert_select "input[value='shed light']", false
  end

  test "should show game as player" do
    sign_in(users(:two))

    get :show, id: @game
    assert_response :success

    assert_select "input[value='Roll dice']"
    assert_select "input[value='cast a shadow']", false
    assert_select "input[value='shed light']"
  end

  test "should show game as gm" do
    sign_in(users(:one))

    get :show, id: @game
    assert_response :success

    assert_select "input[value='Roll dice']"
    assert_select "input[value='cast a shadow']"
    assert_select "input[value='shed light']"
  end

  test "should roll dice" do
    sign_in(users(:one))

    # this should increment the despair pool
    assert_difference 'Game.find_by_id(@game.id).despair' do
      xhr :post, :roll_dice, :id => @game.id, :discipline => 0, :exhaustion => 0, :madness => 0, :pain => 6
    end
  end

  test "shouldn't roll dice" do
    assert_no_difference 'Game.find_by_id(@game.id).despair' do
      xhr :post, :roll_dice, :id => @game.id, :discipline => 0, :exhaustion => 0, :madness => 0, :pain => 6
    end
  end

  test "should cast shadow" do
    sign_in(users(:one))
    
    assert_difference "Game.find_by_id(@game.id).despair", -1 do
      assert_difference "Game.find_by_id(@game.id).hope", +1 do
        xhr :put, :cast_shadow, :id => @game.id, :despair_coins => 1
      end
    end
  end

  test "shouldn't cast shadow" do
    assert_no_difference "Game.find_by_id(@game.id).despair", -1 do
      assert_no_difference "Game.find_by_id(@game.id).hope", +1 do
        xhr :put, :cast_shadow, :id => @game.id, :despair_coins => 1
      end
    end
    
    sign_in(users(:two))
    
    assert_no_difference "Game.find_by_id(@game.id).despair", -1 do
      assert_no_difference "Game.find_by_id(@game.id).hope", +1 do
        xhr :put, :cast_shadow, :id => @game.id, :despair_coins => 1
      end
    end
  end

  test "should shed light" do
    @game.hope = 2
    @game.save
    
    sign_in(users(:one))
    
    assert_difference "Game.find_by_id(@game.id).hope", -1 do
      xhr :put, :shed_light, :id => @game.id, :hope_coins => 1
    end

    sign_in(users(:two))

    assert_difference "Game.find_by_id(@game.id).hope", -1 do
      xhr :put, :shed_light, :id => @game.id, :hope_coins => 1
    end
  end

  test "shouldn't shed light" do
    assert_no_difference "Game.find_by_id(@game.id).hope", -1 do
      xhr :put, :shed_light, :id => @game.id, :hope_coins => 1
    end
  end

  test "should get edit" do
    sign_in(users(:one))

    get :edit, id: @game
    assert_response :success
  end

  test "shouldn't get edit" do
    get :edit
    assert_redirected_to new_user_session_path, @response.message
  end

  test "should update game" do
    sign_in(users(:one))

    put :update, id: @game, game: { despair: @game.despair + 1, hope: @game.hope + 1, name: "new name" }
    assert_redirected_to game_path(assigns(:game))
    @game = Game.find_by_id(games(:one).id)

    assert_equal "new name", @game.name
    assert_equal 2, @game.despair
    assert_equal 2, @game.hope
  end

  test "shouldn't update game" do
    put :update, id: @game, game: { despair: @game.despair + 1, hope: @game.hope + 1, name: "new name" }
    assert_redirected_to new_user_session_path, @response.message
    @game = Game.find_by_id(games(:one).id)

    assert_not_equal "new name", @game.name
    assert_not_equal 2, @game.despair
    assert_not_equal 2, @game.hope
  end

  test "should destroy game" do
    sign_in(users(:one))

    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end

  test "shouldn't destroy game" do
    assert_no_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to new_user_session_path

    sign_in(users(:two))
  
    assert_no_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to root_path
  end
end
