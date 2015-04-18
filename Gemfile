source 'https://rubygems.org'
ruby '2.2.2'
gem 'rails', "4.2.1"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'unicorn'
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
gem 'bootstrap-sass'
# gem 'compass-rails'
gem 'modernizr-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'
gem 'twitter'

gem "will_paginate"
gem "simple_form"
gem "google-analytics-rails"
gem "syllable_counter", github: "lachlanp/syllable_counter", branch: "request"

gem "wordnik"
gem "engtagger"
gem 'heroku_secrets', github: 'alexpeattie/heroku_secrets', branch: 'master'

gem 'sidekiq'
gem 'responders'

gem 'pry-rails'

group :development do
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem "capybara", ">= 1.1.2"
end

group :test, :development do
  gem "rspec-rails", ">= 2.11.0"
  gem "factory_girl_rails", ">= 4.0.0"
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

#keyboard shortcuts, yo
group :production do
  gem 'rails_12factor'
  gem 'heroku_rails_deflate'
end
