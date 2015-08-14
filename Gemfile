ruby '2.2.0'
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.1'

# Passenger as the web server
gem 'passenger', '>= 5.0.4'

# Postgresql as DB
gem 'pg'

# Use HAML for markup
gem 'haml'
gem 'haml-rails', group: :development


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

# Pagination
gem 'kaminari', '~> 0.16.3'

# Update meta tags despite Turbolinks
gem 'metamagic'

# Factory Girl, no need for fixtures
gem 'factory_girl_rails', require: false

# Cloudinary for image CDN and image uploading
gem 'cloudinary'

# Markdown for Blog Writing
gem 'redcarpet'

group :development do
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
  gem 'web-console', '~> 2.1.2'
end

# Heroku gems
gem 'rails_12factor', group: :production
gem 'newrelic_rpm', group: :production
