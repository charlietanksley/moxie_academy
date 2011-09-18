MoxieAcademy.controllers :users do

  # LOGIN {{{

  # get :index, :map => "/foo/bar" do
  get :new, :map => '/login' do
    render 'sessions/new'
  end

  post :create do
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

  delete :destroy do
    session[:logged_in_as] = nil
    session[:logged_in] = nil

    redirect url(:sessions, :new)
  end

  # END LOGIN }}}

end
