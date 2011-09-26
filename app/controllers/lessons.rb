MoxieAcademy.controllers :lessons do#, :conditions => {:protect => true} do
  include UserServices::Authentication

  before do
    verify_logged_in
  end

  layout :lessons_layout

  # INDEX {{{
  get :index do
    @lessons = select_visible(Lesson.all(:order => [:id.desc]))
    render 'lessons/index'
  end

  # END INDEX }}}
  # SHOW {{{

  get :show, :map => 'lessons/:slug' do
    begin
      @lesson = Lesson.first(:slug => params[:slug])
      if visible_to_user?(current_user, @lesson)
        render 'lessons/show'
      else
        flash[:error] = 'You must have a bad url; that lesson does not exist or is not available to you.'
        redirect url(:lessons, :index)
      end
    rescue
      flash[:error] = 'You must have a bad url; that lesson does not exist.'
      redirect url(:lessons, :index)
    end

  end

  # END SHOW }}}

end
