require 'test_helper'

class NewsinfoControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get crolling" do
    get :crolling
    assert_response :success
  end

end
