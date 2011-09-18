Admin.controllers :lessons do

  get :index do
    @lessons = Lesson.all
    render 'lessons/index'
  end

  # NEW {{{

  get :new do
    render 'lessons/new'
  end

  post :create do
    lesson = Lesson.new(params[:lesson])
    if lesson.save!
      flash[:notice] = 'Lesson created.'
      redirect url(:lessons, :index)
    else
      flash[:error] = "Sorry, something went wrong!"
      #redirect url(:lessons, :index)
      #redirect to('/lessons/')
    end
  end

  # END NEW }}}
  # EDIT {{{

  get :edit, :with => :id do
    #@lesson = Lesson.first(:id => params[:id])
    @lesson = Lesson.first(params[:id])
    render 'lessons/edit'
  end

  put :update, :with => :id do
    @lesson = Lesson.first(params[:id])
    if @lesson.update(params[:lesson])
      flash[:notice] = 'Lesson was successfully updated.'
      redirect url(:lessons, :edit, :id => @lesson.id)
    else
      render 'lessons/edit'
    end
  end

  # END EDIT }}}
  # DESTROY {{{

  delete :destroy do
    lesson = Lesson.first(:id => params[:id])
    flash[:notice] = "The lesson '#{lesson.title}' has been removed"
    lesson.destroy
    redirect url(:lessons, :index)
  end

  # END DESTROY }}}


end
__END__


  get :new do
    @account = Account.new
    render 'accounts/new'
  end

  post :create do
    @account = Account.new(params[:account])
    if @account.save
      flash[:notice] = 'Account was successfully created.'
      redirect url(:accounts, :edit, :id => @account.id)
    else
      render 'accounts/new'
    end
  end

  get :edit, :with => :id do
    @account = Account.get(params[:id])
    render 'accounts/edit'
  end

  put :update, :with => :id do
    @account = Account.get(params[:id])
    if @account.update(params[:account])
      flash[:notice] = 'Account was successfully updated.'
      redirect url(:accounts, :edit, :id => @account.id)
    else
      render 'accounts/edit'
    end
  end

  delete :destroy, :with => :id do
    account = Account.get(params[:id])
    if account != current_account && account.destroy
      flash[:notice] = 'Account was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Account!'
    end
    redirect url(:accounts, :index)
  end
end
