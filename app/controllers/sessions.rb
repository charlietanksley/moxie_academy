#MoxieAcademy.controllers :users do
MoxieAcademy.controllers :sessions do

  # get :index, :map => "/foo/bar" do
  get :new, :map => '/login' do
    render 'sessions/new'
  end

  post :create do
    user = User.first(:email => params[:login][:email]) # Deal with wrong email
    if user.nil?
      flash[:error] = 'You must have entered your email address incorrectly.'
      redirect url(:sessions, :new)
    end

    if params[:login][:password].nil?
      flash[:error] = 'You must enter a password.'
      redirect url(:sessions, :new)
    end

    if params[:login][:password] == Group.first(:id => user.group_id).password
      session[:uid] = user.id
      redirect session[:back] if session[:back]
      redirect url(:lessons, :index)
    else
      flash[:error] = 'You must have entered your password address incorrectly.'
      redirect url(:sessions, :new)
    end
  end

  get '/logout' do
    session[:uid] = nil

    redirect url(:sessions, :new)
  end

  delete :destroy do
    session[:uid] = nil

    redirect url(:sessions, :new)
  end

end
