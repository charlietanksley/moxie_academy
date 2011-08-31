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

describe 'If you are not logged in, the app is basically worthless', :type => :request do

  it "requires login to access lessons" do
    visit ('/lessons')
    current_path.should eq('/login')
  end

  it "requires login to access a given lesson" do
    visit '/lessons/first'
    current_path.should eq('/login')
  end

end

describe 'If you are logged in, we get content', :type => :request do

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
    
  it 'shows me the lessons page' do
    visit '/lessons'
    current_path.should eq('/lessons')
  end

  it 'shows me the page for a specific lesson, at its slug' do
    visit '/lessons/test'
    current_path.should eq('/lessons/test')
  end

  it 'sends me to a 404 page when there is no such lesson' do
    visit '/lessons/does-not-exist'
    current_path.should eq('/')
  end
end
