Admin.controllers :base do

  # This is the dashboard.
  get :index, :map => "/" do
    #@lessons = Lesson.all
    #@users = User.all
    #@groups = Group.all
    #render "base/index"
    render 'lessons/index'
  end

end
