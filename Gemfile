source "http://rubygems.org"

gem 'sinatra'
gem 'rack-flash'

# DB
gem 'data_mapper'
gem 'dm-postgres-adapter'
gem 'bcrypt-ruby', :require => 'bcrypt'

# VIEWS
gem 'slim'

# DEPLOYMENT
gem 'thin'

group :development do
  gem 'dm-sqlite-adapter'
  gem 'tux'
  gem 'compass'
  gem 'compass-susy-plugin'
  gem 'sass'
  gem 'foreman'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'database_cleaner', :git => 'https://github.com/bmabey/database_cleaner.git'
end
