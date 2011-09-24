MoxieAcademy.controllers :lessons do#, :conditions => {:protect => true} do
  include UserServices::Authentication

  before do
    verify_logged_in
  end

  # INDEX {{{
  get :index do
    @lessons = Lesson.all(:order => [:id.desc])
    render 'lessons/index'
  end

  # END INDEX }}}
  # SHOW {{{

  get :show, :map => 'lessons/:slug' do
    begin
      @lesson = Lesson.first(:slug => params[:slug])
      verify_visible_to_user?(User.first(:id => session[:uid]), @lesson)
    rescue
      flash[:error] = 'You must have a bad url; that lesson does not exist.'
      redirect url(:lessons, :index)
    end

    render 'lessons/show'
  end

  # END SHOW }}}

end
