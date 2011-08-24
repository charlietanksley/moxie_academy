require 'sinatra/base'
require 'data_mapper'
require 'dm-validations'
require 'slim'

class MoxieApp < Sinatra::Base

  # DATAMAPPER {{{

  DataMapper.setup(:default,
     ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

  class User
    include DataMapper::Resource

    property :id,         Serial
    property :email,      String
    property :password,   String
    property :first_name, String
    property :last_name,  String
    property :start_date, DateTime
    property :end_date,   DateTime

    validates_presence_of :email
    validates_presence_of :password
  end

  class Lesson
    include DataMapper::Resource

    property :id,         Serial
    property :title,      String
    property :slug,       String, :key => true
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

  Slim::Engine.set_default_options :sections => true

  # END CONFIG }}}
  # HELPERS {{{
  helpers do

    # CRIBBED FROM THEPHILOSOPHER.ME {{{
    #def authenticate_admin
    #  unless session['logged_in_as'] == 'charlietanksley'
    #    redirect '/'
    #  end
    #end

    #def authenticate( username )
    #  unless session['logged_in_as'] == username or session['logged_in_as'] == 'charlietanksley'
    #    redirect "/login/#{username}"
    #  end
    #end

    #def login( username, auth_hash, redirect_target )
    #  user = Person.where(:username => username).first
    #  let_in = false
    #  if user.provider.nil?
    #    user.update_attributes(:uid => auth_hash['uid'], :provider => auth_hash['provider']) 
    #    session['logged_in_as'] = username
    #    let_in = true
    #  elsif user.uid == auth_hash['uid']
    #    if user.provider == auth_hash['provider']
    #      session['logged_in_as'] = username
    #      let_in = true
    #    end
    #  else
    #    session['logged_in_as'] == nil
    #  end
    #  to_next = let_in ? redirect_target : "/login/#{username}"
    #  redirect to_next
    #end
    #
    # END }}}

  end
  
  
  # END HELPERS }}}
  # ROUTES/CONTROLLERS {{{

  # INDEX
  get '/' do
    @title = 'Moxie Academy by Joy Tanksley'
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
