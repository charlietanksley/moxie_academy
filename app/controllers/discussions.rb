MoxieAcademy.controllers :discussions do
  include UserServices::Authentication

  before do
    verify_logged_in
  end

  #layout :lessons_layout

  # INDEX {{{
  get :index do
    @discussions = Discussion.first(:group_id => current_user.group_id).comments#.discussion_for(current_user.group_id)
    render 'discussions/index'
  end

  # END INDEX }}}
  # SHOW {{{

  #get :show, :map => 'lessons/:slug' do
  #  begin
  #    @lesson = Lesson.first(:slug => params[:slug])
  #    render 'lessons/show'
  #  rescue
  #    flash[:error] = 'You must have a bad url; that lesson does not exist.'
  #    redirect url(:lessons, :index)
  #  end

  #end

  # END SHOW }}}

end
