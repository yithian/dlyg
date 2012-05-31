require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end
  
  # assure email addresses are unique
  test "email uniqueness" do
    user2 = users(:two)
    
    @user.email = user2.email
    
    assert (not @user.save), "saved with a duplicate email"
  end
end
