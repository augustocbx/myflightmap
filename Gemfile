source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.10'

# use PostgreSQL in staging and production
gem 'pg'

# App configuration manager
gem 'figaro'

# Application server
gem 'puma'

# Heroku support gem
gem 'rails_12factor', group: :production

# Need >= 3.1 for bootstrap 3 support
gem 'simple_form', '~> 3.1'

# Nice country helper. Among other things, parse names into ISO codes
gem 'countries'

# Country drop-down (uses data from countries gem)
gem 'country_select'

# Support SLIM templating engine
gem 'slim'

# Dropdown replacement with AJAX support
gem 'select2-rails'

# Date picker
gem 'pickadate-rails'

# Advanced querying with ActiveRecord
gem 'arel'

# Model security
gem 'pundit'

# Decorators
gem 'draper'

# Use devise for the auth and registration framework
gem 'devise'

# Allow Facebook and Google auth in devise
gem 'omniauth-facebook', '~> 4.0.0'
gem 'omniauth-google-oauth2'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.2'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Needed to figure out the time at the airport
gem 'tzinfo'

# XML parser, handy for parsing HTML for scraping
gem 'nokogiri'

# Markdown
gem 'redcarpet'

# HTTParty for consuming JSON APIs
gem 'httparty'

# Attaching files to records
gem 'paperclip', '~> 4.3.6'

# Nice lib for dealing with durations of time and formatting them
gem 'ruby-duration'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Bootstrap for general site layouts
gem 'bootstrap-sass', '~> 3.3.0'

# Add Font Awesome support (icons as font glyphs)
gem 'font-awesome-rails', '~> 4.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Automatically add CSS prefixes when necessary
gem 'autoprefixer-rails'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0'

# Pseudo-gems for Bower packages
source 'https://rails-assets.org' do
  gem 'rails-assets-handlebars'
  gem 'rails-assets-typeahead.js'
end

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.0.4'

# Change tracking for ActiveRecord models
gem 'audited-activerecord', '~> 4.0'

# Easily slugged URLs
gem 'friendly_id', '~> 5.0.0'

# Generate unique, reversible IDs
gem 'hashids'

# Error reporting
gem 'rollbar'

group :development do
  gem 'capistrano',            require: false
  gem 'capistrano-bundler',    require: false
  gem 'capistrano-figaro-yml', require: false
  gem 'capistrano-foreman',    require: false
  gem 'capistrano-rails',      require: false
  gem 'capistrano-rbenv',      require: false
  gem 'capistrano3-puma',      require: false

  # Automatically run tests when files change
  gem 'guard-brakeman', require: false
  gem 'guard-bundler', require: false
  gem 'guard-pow', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false

  # Enforce Ruby coding style
  gem 'rubocop', '~> 0.49.0', require: false

  # needed for CSV parsing
  gem 'stdlib'

  # allows organization of data seeding tasks
  gem 'seedbank'

  # generate files for an application layout, navigation links, and flash messages
  gem 'rails_layout'

  # Hush the asset pipeline logging
  gem 'quiet_assets'

  # Notifications on macOS
  gem 'terminal-notifier-guard'
end

group :development, :test do
  # Spec testing
  gem 'rspec-rails'

  # Code coverage analysis
  gem 'simplecov', require: false

  # Acceptance testing
  gem 'capybara'

  # Generates fake test data
  gem 'faker'

  # Object factory
  gem 'factory_girl_rails'

  # Detect missing eager-loading or unnecessary eager-loading
  gem 'bullet'
end

group :test do
  # Matchers for RSpec
  gem 'shoulda-matchers', require: false

  # Cleans up the database after tests
  gem 'database_cleaner'

  # Driver for Capybara. Allows for image screenshots
  gem 'poltergeist'

  # Save screenshots of failed acceptance tests
  gem 'capybara-screenshot'
end

# Application performance monitoring
gem 'newrelic_rpm', group: %i(staging production)
