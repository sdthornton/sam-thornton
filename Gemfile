ruby '2.2.0'
source 'https://rubygems.org'

# # Use jruby with Ruby 1.9.3
# ruby '1.9.3', engine: 'jruby', engine_version: '1.7.14'

# gem 'mysql2', platform: :jruby
# gem 'activerecord-jdbcmysql-adapter', platform: :jruby

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.1'

# Passenger as the web server
gem 'passenger', '>= 5.0.4'

# Postgresql as DB
gem 'pg'

# Use HAML for markup
gem 'haml'
gem 'haml-rails', group: :development

# Use Sass for stylesheets
gem 'sass-rails', '~> 5.0.1'
gem 'compass-rails', '~> 2.0.4'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.0.3'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'nprogress-rails'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Better forms
gem 'simple_form'

# Pony mailer
gem 'pony'

# Devise for Users
gem 'devise', '~> 3.4.1'

# Has Scope for better scoping
gem 'has_scope'

# Paperclip for Uploading Files
gem 'paperclip', '~> 4.2.1'

# Pagination
gem 'kaminari', '~> 0.16.3'

# Update meta tags despite Turbolinks
gem 'metamagic'

# Factory Girl, no need for fixtures
gem 'factory_girl_rails', require: false

group :development do
  gem 'capistrano' # For easy deploys
  gem 'capistrano-ext' # For easy deploys
  gem 'better_errors', '~> 1.1.0' # Better rails errors
  gem 'brakeman', require: false # Check for security vulnerabilities
  gem 'bullet' # Help reduce number of queries
  gem 'parallel_tests'
  gem 'delorean'
  gem 'pry-rails'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda'
  gem 'mocha', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0.0.beta4'
end

gem 'rails_12factor', group: :production
gem 'newrelic_rpm'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use debugger
# gem 'debugger', group: [:development, :test]

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
