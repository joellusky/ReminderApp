require 'test_helper'

class AboutControllerTest < ActionController::TestCase
  test "should get howitworks" do
    get :howitworks
    assert_response :success
  end

  test "should get aboutus" do
    get :aboutus
    assert_response :success
  end

end
