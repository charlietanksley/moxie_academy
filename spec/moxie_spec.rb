require 'spec_helper'

describe "My App" do
  def app
    @app ||= MoxieApp
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end

end

describe 'If you are not logged in, you', :type => :request do

  it "get redirected when you try to view the lessons overview" do
    visit ('/lessons')
    current_path.should eq('/login')
  end

  it "get redirected when you try to view a specific lesson" do
    visit '/lessons/first'
    current_path.should eq('/login')
  end

end

describe 'If you are logged in, you', :type => :request do

  before(:all) do
    MoxieApp::Group.create(:name => 'Test', :password => 'password')
    MoxieApp::User.create(:email => 'user@example.com', :group_id => 1)
    MoxieApp::Lesson.create(:video_title => 'whatever', :slug => 'test')
  end

  before(:each) do
    visit '/login'
    fill_in 'login[email]', :with => 'user@example.com'
    fill_in 'login[password]', :with => 'password'
    click_button 'Sign In'
  end
    
  it 'can view the lessons overview page' do
    visit '/lessons'
    current_path.should eq('/lessons')
  end

  it 'can view a specific lesson' do
    visit '/lessons/test'
    current_path.should eq('/lessons/test')
  end

  it 'get redirected if the page does not exist' do
    visit '/lessons/does-not-exist'
    current_path.should eq('/')
  end
end
