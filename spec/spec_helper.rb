require 'rspec'
require 'rack/test'

# Sinatra testing stuff
require File.join(File.dirname(__FILE__), '..', 'moxie.rb')
require 'sinatra'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
#require 'database_cleaner'

Capybara.app = MoxieApp
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false



RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  #config.before(:suite) do
  #  DatabaseCleaner.strategy = :truncation
  #  DatabaseCleaner.orm = "datamapper"
  #end

  #config.before(:each) do
  #  DatabaseCleaner.start
  #end

  #config.after(:each) do
  #  DatabaseCleaner.clean
  #end

end
