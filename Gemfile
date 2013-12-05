source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', "4.0.2"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'unicorn'
gem 'newrelic_rpm'
gem 'pg'
gem 'yaml_db', github: 'jetthoughts/yaml_db', branch: 'rails4'

# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails', "~> 4.0.0"
gem 'coffee-rails', "~> 4.0.0"
gem 'bootstrap-sass'
gem 'bootswatch-rails'
# gem 'compass-rails'
gem 'modernizr-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'
gem 'twitter', "~> 4.8.1"
gem 'google-api-client'
gem 'jquery-rails'
gem 'haml-rails'
gem "will_paginate"
gem "simple_form"
gem "thin"
gem "google-analytics-rails"
gem "syllable_counter", github: "lachlanp/syllable_counter", branch: "request"
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
group :development do
  gem 'quiet_assets'
  gem "debugger", :platforms => [:mingw_19, :ruby_19]
  gem 'byebug', :platforms => [:mingw_20, :ruby_20]
  gem 'pry-byebug', :platforms => [:mingw_20, :ruby_20]
  gem 'pry-stack_explorer', :platforms => [:mingw_20, :ruby_20]
  gem "better_errors"
  gem 'binding_of_caller'
end

group :test do
  gem "capybara", ">= 1.1.2"
end

group :test, :development do
  gem "rspec-rails", ">= 2.11.0"
  gem "factory_girl_rails", ">= 4.0.0"
end

gem "devise", ">= 3.0.0"
# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

#keyboard shortcuts, yo
gem 'mousetrap-rails'
group :production do
  gem 'rails_12factor'
end
