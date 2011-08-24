require 'rubygems'
require 'sinatra/base'
require 'data_mapper'
require 'dm-validations'
require 'slim'

class MoxieApp < Sinatra::Base

  # DATAMAPPER {{{

  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

  class User
    include DataMapper::Resource

    property :id,         Serial
    property :email,      String
    property :password,   String
    property :first_name, String
    property :last_name,  String
    property :start_date, DateTime
    property :end_date,   DateTime
    property :paid,       Boolean, :default => false

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
  
  DataMapper.auto_upgrade!

  # END DataMapper }}}
  # CONFIG {{{

  set :public, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/views'

  set :sessions, true

  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  #Slim::Engine.set_default_options :sections => true

  # END CONFIG }}}
  # HELPERS {{{
  helpers do
    def authenticate_admin
      unless session[:logged_in_as] == 'admin'
        redirect '/login'
      end
    end

    def true?
      'true'
    end

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

  # INDEX {{{

  get '/' do
    @title = 'Moxie Academy by Joy Tanksley'
    slim :index
  end

  # END INDEX }}}
  # LOG IN {{{

  get '/login' do
    slim :'users/login'
  end

  post '/login' do
    redirect to('/lessons')
  end

  # END LOGIN }}}
  # LESSONS {{{

  get '/lessons' do
    slim :'lessons/index'
  end

  get '/lessons/:page' do
    @lesson = params[:page]
    slim :'lessons/show'
  end

  # END LESSONS }}}
  # PAYMENT {{{

  get '/users/payment' do
    slim :'users/payment'
  end

  # END PAYMENT }}}
  # ADMIN TASKS {{{

  get '/admin' do
    slim :"admin/index"
  end

  # redirect
  get '/admin/' do
    redirect to('/admin')
  end

  get '/admin/new-lesson' do
    slim :'lessons/new'
  end

  post '/admin/new-lesson' do
    # Take action
  end

  get '/admin/users' do
    authenticate_admin
    @users = MoxieApp::User.all
    slim :'admin/users'
  end

  # END ADMIN }}}

  # END ROUTES }}}
  # DEVELOPMENT ROUTES {{{

  get '/development/add-users' do
    u = MoxieApp::User.create(
      :email => 'tmp@email.com',
      :password => 'insecure',
      :first_name => 'Charlie',
      :last_name => 'Tanksley',
      :start_date => 'September 2011',
      :paid => false)
    u2 = MoxieApp::User.create(
      :email => 't@secondemail.com',
      :password => 'insecure',
      :first_name => 'Joy',
      :last_name => 'Tanksley',
      :start_date => 'September 2011',
      :paid => true)
    redirect to('/admin/users')
  end

  get '/development/remove-users' do
    MoxieApp::Users.destroy!
    redirect to('/admin/users')
  end

  get '/development/login-admin' do
    session[:logged_in_as] = 'admin'
    redirect to ('/admin/users')
    #redirect to ('/development/wtf')
  end

  get '/development/logout' do
    session[:logged_in_as] = nil
  end
  
  get '/development/wtf' do
    "#{session[:logged_in_as]}"
  end
  
  # END DEVELOPMENT ROUTES }}}

end
