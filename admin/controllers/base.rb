Admin.controllers :base do

  # This is the dashboard.
  get :index, :map => "/" do
    @lessons = Lesson.all
    @users = User.all
    @groups = Group.all
    render "base/index"
  end

end
__END__
  get :that, :map => '/that' do
    "that!"
  end
              # NEW {{{

  get '/lessons/new' do
    'new lesson'
    #render 'lessons/new'
  end

  post '/lessons/new' do
    lesson = Lesson.new(params[:lesson])
    if lesson.save!
      @lesson = lesson
      redirect ("/lessons/#{@lesson.slug}")
    else
      flash[:error] = "Sorry, something went wrong!"
      redirect to('/lessons/new-lesson')
    end
  end

  # END NEW }}}
  # EDIT {{{

  get 'lessons/edit/:id' do
    "Lesson #{params[:id]}"
    #@lesson = Lesson.first(:id => params[:id])
    #render 'lessons/edit'
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
