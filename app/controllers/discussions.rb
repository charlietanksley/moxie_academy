MoxieAcademy.controllers :discussions do
  include UserServices::Authentication

  before do
    verify_logged_in
  end

  #layout :lessons_layout

  get :index do
    @discussions = Discussion.discussion_for(current_user.group_id)
    render 'discussions/index'
  end

  post :create do
    comment = Comment.new(params[:discussion])
    if comment.save
      redirect url(:discussions, :index)
    else
      flash[:error] = "Sorry, something went wrong!"
      redirect url(:discussions, :index)
    end
  end


  #get :show, :map => 'lessons/:slug' do
  #  begin
  #    @lesson = Lesson.first(:slug => params[:slug])
  #    render 'lessons/show'
  #  rescue
  #    flash[:error] = 'You must have a bad url; that lesson does not exist.'
  #    redirect url(:lessons, :index)
  #  end

  #end

end
