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
      @lesson = lesson
      redirect ("/lessons/#{@lesson.slug}")
    else
      flash[:error] = "Sorry, something went wrong!"
      redirect to('/lessons/')
    end
  end

  # END NEW }}}
  # EDIT {{{

  get :edit do
    @lesson = Lesson.first(:id => params[:id])
    render 'lessons/edit'
  end

  post :edit do
    lesson_info = remove_empty_fields(params[:lesson])
    lesson = Lesson.first(:id => lesson_info['id'])
    if lesson.update lesson_info
      flash[:notice] = 'Success!'
      redirect to('/admin/lessons')
    else
      flash[:error] = 'Something went wrong :('
    end
  end

  # END EDIT }}}
  # DESTROY {{{

  get :destroy do
    lesson = Lesson.first(:id => params[:id])
    flash[:notice] = "The lesson '#{lesson.title}' has been removed"
    lesson.destroy
    redirect to('/admin/lessons')
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
