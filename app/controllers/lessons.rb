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
