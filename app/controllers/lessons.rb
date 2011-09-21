MoxieAcademy.controllers :lessons do#, :conditions => {:protect => true} do
  include UserServices::Authentication

  #before do
  #  unless session[:uid]
  #    redirect url(:sessions, :new)
  #  end
  #end

  #def self.protect(*args)
  #  condition {
  #    unless session[:logged_in] == true
  #      flash[:error] = 'You must be logged in to access a lesson'
  #      redirect url(:sessions, :new)
  #    end
  #  }
  #end

  # INDEX {{{
  get :index do
    @lessons = Lesson.all(:order => [:id.desc])
    render 'lessons/index'
  end

  # END INDEX }}}
  # SHOW {{{
  # (has to be last or it will gobble up all lesson paths!)

  get :show, :map => 'lessons/:slug' do
    unless session[:uid]
      redirect url(:sessions, :new)
    end
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
