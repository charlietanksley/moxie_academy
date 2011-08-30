require 'rubygems'
require 'sinatra/base'
require 'thin'
require 'rack-flash'
require 'data_mapper'
require 'dm-validations'
require 'bcrypt'
require 'slim'

class MoxieApp < Sinatra::Base

  # DATAMAPPER {{{

  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

  class User
    include DataMapper::Resource

    property :id,         Serial
    property :email,      String
    property :group_id,   Integer

    belongs_to :group
    validates_presence_of   :email
    validates_presence_of   :group_id
  end

  class Group
    include DataMapper::Resource

    property :id,         Serial
    property :name,       String
    property :password,   String

    has n, :users
    validates_uniqueness_of :name
    validates_presence_of   :password
  end

  class Lesson
    include DataMapper::Resource

    property :id,           Serial
    property :title,        String
    property :slug,         String, :key => true
    property :body,         Text
    property :video_title,  String
    property :poster_name,  String

    validates_presence_of   :video_title
    validates_presence_of   :slug
    validates_uniqueness_of :slug
  end

  DataMapper.finalize
  DataMapper.auto_upgrade!

  # END DataMapper }}}
  # CONFIG {{{

  set :public, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/views'

  set :sessions, true
  use Rack::Flash

  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  #Slim::Engine.set_default_options :sections => true

  # END CONFIG }}}
  # HELPERS {{{
  helpers do
    def authenticate_admin
      unless session[:logged_in_as] == 'admin'
        session[:back] = request.path_info
        redirect '/admin/login'
      end
    end

    def authenticate_logged_in
      unless session[:logged_in]
        session[:back] = request.path_info
        redirect '/login'
      end
    end

    def cache_it
      # 1 day cache?
      response.headers['Cache-Control'] = 'public, max-age=86400'
    end

    def remove_empty_fields(hash)
      hash.select { |k,v| v != '' }
    end

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
    credentials = params[:login]
    user = MoxieApp::User.first(:email => credentials[:email])
          
    if user.group.password == credentials[:password]
      session[:logged_in_as] = user.group_id
      session[:logged_in] = true
      if session[:back]
        redirect to(session[:back])
      end
      redirect to('/')
    else
      flash[:error] = 'There seems to have been a problem.  Please enter your email and password again.'
      redirect to('/login')
    end
  end

  get '/admin/login' do
    slim :'admin/login'
  end

  post '/admin/login' do
    credentials = params[:login]
    if credentials[:name] == 'admin' && credentials[:password] == ENV['ADMIN_PASSWORD']
      session[:logged_in_as] = 'admin'
      session[:logged_in] = true
      redirect to('/admin')
    else
      flash[:error] = 'There seems to have been a problem.  Please enter your email and password again.'
      redirect to('/admin/login')
    end

  end

  # END LOGIN }}}
  # LOGOUT {{{

  get '/logout' do
    session[:logged_in_as] = nil
    session[:logged_in] = nil
    flash[:notice] = 'You have successfully logged out.'
    redirect to('/login')
  end

  
  
  # END LOGOUT }}}
  # LESSONS {{{

  get '/lessons' do
    authenticate_logged_in
    @lessons = MoxieApp::Lesson.all
    slim :'lessons/index'
  end

  get '/lessons/:slug' do
    authenticate_logged_in
    @lesson = Lesson.first(:slug => params[:slug])
    slim :'lessons/show'
  end

  # END LESSONS }}}
  # USERS {{{

  # END USERS }}}
  # ADMIN TASKS {{{

  # MAIN {{{

  get '/admin' do
    authenticate_admin
    slim :"admin/index"
  end

  # redirect
  get '/admin/' do
    redirect to('/admin')
  end
  
  # END MAIN }}}
  # ADMIN LESSON TASKS {{{

  get '/admin/lessons' do
    authenticate_admin
    @lessons = MoxieApp::Lesson.all
    slim :'admin/lessons'
  end

  get '/admin/lessons/:id/edit' do
    authenticate_admin
    @lesson = MoxieApp::Lesson.first(:id => params[:id])
    slim :'lessons/edit'

  end

  post '/admin/edit-lesson' do
    authenticate_admin
    lesson_info = remove_empty_fields(params[:lesson])
    lesson = MoxieApp::Lesson.first(:id => lesson_info['id'])
    if lesson.update lesson_info
      flash[:notice] = 'Success!'
      redirect to('/admin/lessons')
    else
      flash[:error] = 'Something went wrong :('
    end
  end

  get '/admin/lessons/:id/destroy' do
    authenticate_admin
    lesson = MoxieApp::Lesson.first(:id => params[:id])
    flash[:notice] = "The lesson '#{lesson.title}' has been removed"
    lesson.destroy
    redirect to('/admin/lessons')
  end

  # New lesson
  get '/admin/new-lesson' do
    authenticate_admin
    slim :'lessons/new'
  end

  post '/admin/new-lesson' do
    authenticate_admin
    lesson = MoxieApp::Lesson.new(params[:lesson])
    if lesson.save!
      @lesson = lesson
      redirect ("/lessons/#{@lesson.slug}")
    else
      flash[:error] = "Sorry, something went wrong!"
      redirect to('/lessons/new-lesson')
    end
  end

  # END ADMIN LESSON TASKS }}}
  # ADMIN USER TASKS {{{

  get '/admin/users' do
    authenticate_admin
    @users = MoxieApp::User.all
    @groups = MoxieApp::Group.all
    slim :'admin/users'
  end

  # Edit an individual user
  get '/admin/users/:id/edit' do
    authenticate_admin
    @user = MoxieApp::User.first(:id => params[:id])
    @groups = MoxieApp::Group.all
    slim :'admin/edit-user'
  end

  post '/admin/edit-user' do
    authenticate_admin
    credentials = remove_empty_fields(params[:user])
    user = MoxieApp::User.first(:id => credentials['id'])
    if user.update credentials
      flash[:notice] = 'Success!'
      redirect to('/admin/users')
    else
      flash[:error] = 'Something went wrong :('
      redirect to('/admin/users')
    end
  end

  # Destroy a user
  get '/admin/users/:id/destroy' do
    authenticate_admin
    user = MoxieApp::User.first(:id => params[:id])
    flash[:notice] = "The account for #{user.email} has been removed"
    user.destroy
    redirect to('/admin/users')
  end


  # Create a new user
  post '/admin/users/new' do
    authenticate_admin
    credentials = params[:user]
    user = MoxieApp::User.new(credentials)
    if user.save
      flash[:notice] = 'Success!'
      redirect to('/admin/users')
    else
      flash[:error] = 'Something went wrong :('
      redirect to('/admin/users')
    end
  end

  # END ADMIN USER TASKS }}}
  # ADMIN GROUP TASKS {{{
  
  get '/admin/groups' do
    authenticate_admin
    @groups = MoxieApp::Group.all
    slim :'admin/groups'
  end
  
  post '/admin/new-group' do
    authenticate_admin
    group = MoxieApp::Group.new(params[:group])
    if group.save
      flash[:notice] = 'Group created.'
      redirect ("/admin/groups")
    else
      flash[:error] = "Sorry, something went wrong!"
      redirect to('/admin/groups#new')
    end
  end

  # END ADMIN GROUP TASKS }}}
  
  # END ADMIN }}}

  # END ROUTES }}}
  # DEVELOPMENT ROUTES {{{

  get '/development/login-admin' do
    session[:logged_in_as] = 'admin'
    session[:logged_in] = true
    redirect to ('/admin')
  end

  get '/development/login-user' do
    session[:logged_in] = true
    redirect to ('/lessons')
  end

  get '/development/wtf' do
    "#{session}<br/>#{session[:logged_in] ? 'logged in' : 'not'}"
  end

  # END DEVELOPMENT ROUTES }}}

end
