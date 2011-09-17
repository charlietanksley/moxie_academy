MoxieAcademy.controllers :users do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  # LOGIN {{{

  get '/login' do
    render 'users/login'
  end

  post '/login' do
    credentials = params[:login]
    user = User.first(:email => credentials[:email])
          
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

  # END LOGIN }}}

end
