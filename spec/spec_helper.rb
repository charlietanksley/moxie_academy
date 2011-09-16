require 'rspec'
require 'rack/test'

# Sinatra testing stuff
require File.join(File.dirname(__FILE__), '..', 'moxie.rb')
require 'sinatra'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require 'database_cleaner'
require 'factory_girl'

require 'factories'

Capybara.app = MoxieApp
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

ENV['ADMIN_PASSWORD'] = 'password'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Factory::Syntax::Methods

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

def create_test_group
  MoxieApp::Group.create(:name => 'Test', :password => 'password')
end

def create_test_user_with_password(group_id)
  MoxieApp::User.create(:email => 'user@example.com', :group_id => group_id)
end

def create_test_lesson
  MoxieApp::Lesson.create(:title => 'Title', :video_title => 'whatever', :slug => 'test')
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

def admin_user_path
  '/admin/users'
end
