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
    @lessons = Lesson.all(:order => [:id.desc])
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
      flash[:error] = 'You must have a bad url; that lesson does not exist.'
      redirect url(:lessons, :index)
    end
  end

  # END SHOW }}}

end
