Admin.controllers :users do

  # INDEX {{{

  get :index do
    @users = User.all
    @groups = Group.all
    render 'admin/users'
  end

  # INDEX }}}
  # NEW {{{

  get :new do
    render 'users/new'
  end

  post :create do
    credentials = params[:user]
    user = User.new(credentials)
    if user.save
      flash[:notice] = 'Success!'
      redirect to('/admin/users')
    else
      flash[:error] = 'Something went wrong :('
      redirect to('/admin/users')
    end
  end

  # END NEW }}}
  # EDIT {{{

  get :edit, :with => :id do
    @user = User.first(:id => params[:id])
    @groups = Group.all
    render 'admin/edit-user'
  end

  post :update, :with => :id do
    credentials = remove_empty_fields(params[:user])
    user = User.first(:id => credentials['id'])
    if user.update credentials
      flash[:notice] = 'Success!'
      redirect to('/admin/users')
    else
      flash[:error] = 'Something went wrong :('
      redirect to('/admin/users')
    end
  end
  
  # END EDIT }}}
  # DESTROY {{{

  delete :destroy, :with => :id do
    user = User.first(:id => params[:id])
    #if account != current_account && account.destroy
    #  flash[:notice] = 'Account was successfully destroyed.'
    #else
    #  flash[:error] = 'Unable to destroy Account!'
    #end
    #redirect url(:accounts, :index)
    flash[:notice] = "The account for #{user.email} has been removed"
    user.destroy
    redirect to('/admin/users')
  end

  # END DESTROY }}}

end
