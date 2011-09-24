require 'spec_helper'

describe "LessonsController" do
  before do
    @l = create(:lesson)
    @l2 = create(:lesson)
  end

  describe 'The lessons index page' do
    it "prints out all the available lessons" do
      #MoxieAcademy.any_instance.stub(:logged_in?).and_return(true)
      UserServices::Authentication.stub(:logged_in?).and_return(true)

      get MoxieAcademy.url(:lessons, :index)#"/lessons"
      last_response.body.should include(@l.title)
      last_response.body.should include(@l2.title)
    end

    pending 'shows all the videos in reverse order' do
      get "/lessons"
      @l.id.should be < @l2.id
      a = last_response.body

      a.index(/#{@l.slug}/).should be > a.index(/#{@l2.slug}/)
    end
  end

  describe 'An individual lesson page' do
    pending 'shows the right lesson' do
      get "/lessons/#{@l.slug}"

      last_response.body.should include(@l.title)
      last_response.body.should include(@l.body)
    end

    pending 'redirects properly when the lesson is not found' do
      get '/lessons/does-not-exist-23419'

      last_response.status.should == 302
      last_response.location.should =~ /\/lessons$/
      #last_response.
    end
  end
end
