require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "root should be home#index" do
  	assert_routing '/', controller: "home", action: "index"
  end

end
