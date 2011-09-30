Admin.controllers :groups do

  get :index do
    @groups = Group.all
    render 'groups/index'
  end

  # NEW {{{

  get :new do
    render 'groups/new'
  end

  post :create do
    group = Group.new(params[:group])
    if group.save!
      flash[:notice] = 'Group created.'
      redirect url(:groups, :index)
    else
      flash[:error] = "Sorry, something went wrong!"
      #redirect url(:groups, :index)
      #redirect to('/groups/')
    end
  end

  # END NEW }}}
  # EDIT {{{

  get :edit, :with => :id do
    #@group = Group.first(:id => params[:id])
    @group = Group.first(params[:id])
    render 'groups/edit'
  end

  put :update, :with => :id do
    @group = Group.first(params[:id])
    if @group.update(params[:group])
      flash[:notice] = 'Group was successfully updated.'
      redirect url(:groups, :edit, :id => @group.id)
    else
      render 'groups/edit'
    end
  end

  # END EDIT }}}
  # DESTROY {{{

  delete :destroy do
    group = Group.first(:id => params[:id])
    flash[:notice] = "The group '#{group.name}' has been removed"
    group.destroy
    redirect url(:groups, :index)
  end

  # END DESTROY }}}

end

