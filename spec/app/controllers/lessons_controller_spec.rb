require 'spec_helper'

describe "LessonsController" do
  before do
    @l = create(:lesson)
    @l2 = create(:lesson)
  end

  describe 'The lessons index page' do
    it "prints out all the available lessons" do
      get "/lessons"
      last_response.body.should include(@l.title)
      last_response.body.should include(@l2.title)
    end

    it 'shows all the videos in reverse order' do
      get "/lessons"
      @l.id.should be < @l2.id
      a = last_response.body

      a.index(/#{@l.slug}/).should be > a.index(/#{@l2.slug}/)
    end
  end

  describe 'An individual lesson page' do

  end
end
