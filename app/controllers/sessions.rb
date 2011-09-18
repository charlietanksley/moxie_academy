#MoxieAcademy.controllers :users do
MoxieAcademy.controllers :sessions do

  # get :index, :map => "/foo/bar" do
  get :new, :map => '/login' do
    render 'sessions/new'
  end

  post :create, :map => '/login' do
    credentials = params[:login]
    user = User.first(:email => credentials[:email])
          
    if user.group.password == credentials[:password]
      session[:logged_in_as] = user.group_id
      session[:logged_in] = true
      if session[:back]
        redirect to(session[:back])
      end
      redirect url(:lessons, :index)
    else
      flash[:error] = 'There seems to have been a problem.  Please enter your email and password again.'
      redirect url(:sessions, :new)
    end
  end

  get '/logout' do
    #redirect url(:sessions, :destroy, :method => :delete)
    session[:logged_in_as] = nil
    session[:logged_in] = nil

    redirect url(:sessions, :new)
  end

  delete :destroy do
    session[:logged_in_as] = nil
    session[:logged_in] = nil

    redirect url(:sessions, :new)
  end

end
