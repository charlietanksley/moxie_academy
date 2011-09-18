__END__
require 'spec_helper'

describe "LessonsController" do
  before do
    @l = create(:lesson)
    @l2 = create(:lesson)
  end

  describe 'The lessons index page' do
    it 'shows all the lessons' do
      get "/lessons"
      #last_response.body.should include('WTF')
      #last_response.body.should include(@l2.title)
    end
  end

  describe 'The new lesson page' do
    it 'does it' do
      get "/lessons"
      #last_response.body.should == ''
    end

  end
end
