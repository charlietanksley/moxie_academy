require 'sinatra/base'
require 'data_mapper'
require 'slim'

class MoxieApp < Sinatra::Base

  # DataMapper {{{

  DataMapper.setup(:default,
     ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

  class User
    include DataMapper::Resource

    property :id,         Serial
    property :email,      String
    property :first_name, String
    property :last_name,  String
    property :start_date, DateTime
    property :end_date,   DateTime
  end

  class Lesson
    include DataMapper::Resource

    property :id,         Serial
    property :title,      String
    property :slug,       String
    property :body,       Text
    property :mp4,        String
    property :webm,       String
    property :ogv,        String
  end
  
  DataMapper.finalize
  DataMapper.auto_upgrade!

  # END DataMapper }}}
  # CONFIG {{{

  set :public, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/views'

  # END CONFIG }}}
  # ROUTES/CONTROLLERS {{{

  # INDEX
  get '/' do
    slim :index
  end

  # LOG IN
  get '/login' do
    slim :'users/login'
  end

  post '/login' do
    redirect to('/lessons')
  end

  # LESSONS
  get '/lessons' do
    slim :'lessons/index'
  end
  get '/lessons/:page' do
    @lesson = params[:page]
    slim :'lessons/show'
  end

  # PAYMENT
  get '/users/payment' do
    slim :'users/payment'
  end

  # ADMIN TASKS
  get '/admin' do
    slim :"admin/index"
  end

  get '/admin/new-lesson' do
    slim :'lessons/new'
  end

  post '/admin/new-lesson' do
    # Take action
  end

  get '/admin/users' do
    slim :'admin/users'
  end

  # END ROUTES }}}

end
