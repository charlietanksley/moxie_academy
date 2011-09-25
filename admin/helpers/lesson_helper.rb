# Helper methods defined here can be accessed in any controller or view in the application

Admin.helpers do
  def lessons
    Lesson.all
  end

  def lesson
    params[:slug] ? Lesson.first(:slug => params[:slug]) : Lesson.new(params[:lesson])
  end
end
