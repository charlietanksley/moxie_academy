require 'rspec'
require 'rack/test'

require 

# Sinatra testing stuff
require File.join(File.dirname(__FILE__), '..', 'moxie.rb')
require 'sinatra'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require 'database_cleaner'

Capybara.app = MoxieApp
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false



RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

def create_test_user
  MoxieApp::Group.create(:name => 'Test', :password => 'password')
end

def admin_login_path
  '/admin/login'
end

def new_lesson_path
  '/admin/new-lesson'
end

def admin_lesson_path
  '/admin/lessons'
end

def create_new(model, opts={})
  m = ['MoxieApp', model].join('::').constantize
  m.create(opts)
end
