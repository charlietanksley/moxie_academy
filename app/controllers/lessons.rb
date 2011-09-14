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

  # INDEX
  get :index do
  end

  # INDIVIDUAL
  get :show, :with => :slug do
  end

  # NEW
  get :new do
  end

  post :new do
  end

  # EDIT
  get :edit do
  end

  post :edit do
  end
  
end
