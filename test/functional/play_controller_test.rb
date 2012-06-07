require 'test_helper'

class PlayControllerTest < ActionController::TestCase
  def setup
    @play = plays(:one)
  end

  test "should get create" do
    sign_in(users(:one))

    post :create
    assert_response :success
  end

  test "should get update" do
    sign_in(users(:one))

    put :update, id: @play, play: { character_name: "new name" }
    assert_response :success
  end

  test "should get destroy" do
    sign_in(users(:one))

    delete :destroy, id: @play
    assert_response :success
  end

end
