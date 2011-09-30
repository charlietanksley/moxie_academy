Admin.controllers :base do

  # This is the dashboard.
  get :index, :map => "/" do
    @lessons = Lesson.all
    render 'lessons/index'
  end

end
