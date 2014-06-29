ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'pry'
require 'factory_girl'
require 'mocha/setup'
FactoryGirl.find_definitions

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Add more helper methods to be used by all tests here...
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  include Warden::Test::Helpers
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods
end
