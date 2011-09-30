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
    @lesson = Lesson.first(:id => params[:id])
    #@lesson = Lesson.first(params[:id])
    render 'lessons/edit'
  end

  put :update, :with => :id do
    @lesson = Lesson.first(:id => params[:id])
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
