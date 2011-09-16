MoxieAcademy.controllers :lessons do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  # INDEX {{{
  get :index do
    @lessons = Lesson.all
    render 'lessons/index'
  end

  # END INDEX }}}
  # NEW {{{

  get :new do
    render 'lessons/new'
  end

  post :new do
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
  # SHOW {{{
  # (has to be last or it will gobble up all lesson paths!)

  get :show, :map => 'lessons/:slug' do
    begin
      @lesson = Lesson.first(:slug => params[:slug])
      render 'lessons/show'
    rescue
      lesson_not_found
    end
  end

  # END SHOW }}}

end
