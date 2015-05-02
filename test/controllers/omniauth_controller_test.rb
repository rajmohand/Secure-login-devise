require 'test_helper'

class OmniauthControllerTest < ActionController::TestCase
  test "should get callbacks" do
    get :callbacks
    assert_response :success
  end

end
