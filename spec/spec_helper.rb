require 'simplecov'
SimpleCov.start
# SimpleCov.start 'rails'

PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

# Database Cleaner
require 'database_cleaner'

# Capybara
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
Capybara.app = Padrino.application

# Factory Girl
require 'factory_girl'
require 'factories'


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

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  MoxieAcademy.tap { |app|  }
end

ENV['ADMIN_PASSWORD'] = 'password'

class TestHelper

  def self.create_test_group
    Group.create(:name => 'Test', :password => 'password')
  end

  def self.create_test_user_with_password(group_id)
    User.create(:email => 'user@example.com', :group_id => group_id)
  end

  def self.create_test_lesson
    Lesson.create(:title => 'Title', :video_title => 'whatever', :slug => 'test')
  end

end

__END__
For Spork/Guard:
https://gist.github.com/903600
