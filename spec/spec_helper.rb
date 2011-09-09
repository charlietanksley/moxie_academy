PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require 'database_cleaner'
require 'factory_girl'

require 'factories'

Capybara.app = MoxieAcademy
#set :environment, :test
#set :run, false
#set :raise_errors, true
#set :logging, false

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

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  MoxieAcademy.tap { |app|  }
end
