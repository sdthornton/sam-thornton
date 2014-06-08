require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test 'root should be home#index' do
  	assert_routing '/', controller: 'home', action: 'index'
    assert_routing root_path, controller: 'home', action: 'index'
  end

end
