require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "root should be home#index" do
  	assert_routing '/', controller: "home", action: "index"
  end

end
