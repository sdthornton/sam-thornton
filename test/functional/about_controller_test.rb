require 'test_helper'

class AboutControllerTest < ActionController::TestCase
  context "#about" do
    should 'respond to routes' do
      assert_routing '/about', controller: 'about', action: 'about'
      assert_routing about_path, controller: 'about', action: 'about'
    end
  end
end
