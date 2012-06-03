require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  setup do
    @result = results(:one)
  end

  test "should destroy result" do
    sign_in(users(:one))
    
    assert_difference('Result.count', -1) do
      delete :destroy, id: @result
    end

    assert_redirected_to results_path
  end
  
  test "shouldn't destroy result" do
    assert_no_difference "Result.count" do
      delete :destroy, id: @result
    end
    
    sign_in(users(:two))
    
    assert_no_difference "Result.count" do
      delete :destroy, id: @result
    end
  end
end