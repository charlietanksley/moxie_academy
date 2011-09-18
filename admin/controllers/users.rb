Admin.controllers :users do

  get :index do
    @users = User.all
    render 'users/index'
  end

  # NEW {{{

  get :new do
    @groups = Group.all
    render 'users/new'
  end

  post :create do
    user = User.new(params[:user])
    if user.save!
      flash[:notice] = 'User created.'
      redirect url(:users, :index)
    else
      flash[:error] = "Sorry, something went wrong!"
      #redirect url(:users, :index)
      #redirect to('/users/')
    end
  end

  # END NEW }}}
  # EDIT {{{

  get :edit, :with => :id do
    @groups = Group.all
    @user = User.first(params[:id])
    render 'users/edit'
  end

  put :update, :with => :id do
    @user = User.first(params[:id])
    if @user.update(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect url(:users, :edit, :id => @user.id)
    else
      render 'users/edit'
    end
  end

  # END EDIT }}}
  # DESTROY {{{

  delete :destroy do
    user = User.first(:id => params[:id])
    flash[:notice] = "The user '#{user.email}' has been removed"
    user.destroy
    redirect url(:users, :index)
  end

  # END DESTROY }}}

end
